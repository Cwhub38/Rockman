extends KinematicBody2D
class_name Player

var direction= 1
var hud
signal spawn_bullet
signal spawn_fireball
onready var muzzle = $Muzzle 
var fireball = preload("res://Fireball.tscn")
var bullet = preload("res://Bullet.tscn")
var SPEED = 900
var velocity = Vector2(0,0)
var input_vector = Vector2.ZERO
var coins = 0
enum States {AIR = 1, FLOOR}
var state = States.AIR
const RUNSPEED = 7000
const JUMPFORCE = -1100
const GRAVITY = 75
var hp = 21

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot_bullet()
	if Input.is_action_just_pressed("fire"):
		fire_fireball()
	match state:
		States.AIR:
			if is_on_floor():
				state = States.FLOOR
				continue
				$Sprite.play("air")
			if Input.is_action_pressed("move_right"):
				if Input.is_action_pressed("run"):
					velocity.x = RUNSPEED
				else:
					velocity.x = SPEED
					$Sprite.play("walk")
					$Sprite.flip_h = false
			elif Input.is_action_pressed("move_left"):
				if Input.is_action_pressed("run"):
						velocity.x = -RUNSPEED
				else:
					velocity.x = -SPEED
					$Sprite.flip_h = true
			else:
				velocity.x = lerp(velocity.x,0,0.2)
				move_and_fall()
				if Input.is_action_just_pressed("jump"):
					velocity.y = JUMPFORCE
		States.FLOOR:
			if not is_on_floor():
				state = States.AIR
			if Input.is_action_pressed("move_right"):
				if Input.is_action_pressed("run"):
					velocity.x = RUNSPEED
				else:
					velocity.x -= SPEED
					$Sprite.play("walk")
					$Sprite.flip_h = true
			else:
				$Sprite.play("idle")
				velocity.x = lerp(velocity.x,0,0)
				if Input.is_action_just_pressed("jump"):
					velocity.y = JUMPFORCE
					state = States.AIR
					move_and_fall()
				if Input.is_action_just_pressed("shoot"):
					shoot_bullet()
				if Input.is_action_just_pressed("fire"):
						fire_fireball()

func shoot_bullet():
	var direction = 1 if not $Sprite.flip_h else -1
	var f = bullet.instance()
	f.direction = direction
	get_parent().add_child(f)
	f.position.y = position.y + 5 * direction
	f.position.x = position.x + 100 * direction

func fire_fireball():
	var direction = 1 if not $Sprite.flip_h else -1
	var c = fireball.instance()
	c.direction = direction
	get_parent().add_child(c)
	c.position.y = position.y + 5 * direction
	c.position.x = position.x + 5 * direction

func ouch():
	set_modulate(Color(1,0.3,0.3,0.3))
	take_damage(1)

func take_damage(damage):
	hp -= damage
	hp -= 1
	if hp <= 1:
		$Gameover.play()

func trauma():
		$AnimationPlayer.play("camshake")

func is_on_floor():
		velocity = move_and_slide(velocity,Vector2.UP)

func move_and_fall():
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.y = velocity.y + GRAVITY

func _on_Gameover_finished():
	get_tree().change_scene("res://GameOver.tscn")

func _on_PlayerTimer_timeout():
	set_modulate(Color(1,1,1,1))