extends KinematicBody2D
class_name boss

signal add_score
signal enemy_died
var ep = 25
var input_vector = Vector2.ZERO
var speed = 1
var velocity = Vector2(-1,0)
var score = 0
var direction = 1

func ready():
	$AnimationPlayer.play("move")

func _physics_process(delta):
	$AnimationPlayer.play("move")

func take_damage(damage):
	ouch()
	$AnimationPlayer.play("move")
	emit_signal("add_score")
	$explode.play()
	ouch()
	$Sprite.play("fire")
	$AnimationPlayer.play("fire")
	$AnimationPlayer.play("death")
	ep -= damage
	ep -= 1
	if ep <= 1:
		emit_signal("enemy_died")

func ouch():
	$explode.play()

func _on_sides_checker_body_entered(body):
	if body.is_in_group("Bullet"):
		emit_signal("add_score")
		take_damage(1)
	if body.is_in_group("Fireball"):
		emit_signal("add_score")
		take_damage(1)
	if ep <= 1:
		$Sprite.play("explode")
	if body.get_collision_layer() == 1:
		body.take_damage(1)
		emit_signal("enemy_died")
		emit_signal("add_score")
		$Sprite.play("squashed")

func enemy_died():
	ep == 0
	if ep <= 1:
		$Sprite.play("explode")
		set_modulate(Color(3,1,1,1))

func _on_Sprite_animation_finished(body):
	$dieTimer.start()

func _on_dieTimer_timeout():
	queue_free()
