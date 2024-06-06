extends Area2D
class_name Enemy2

signal die
signal add_score
var inout_vector = Vector2.ZERO
var speed = 1
var score = 0
var direction = 1
var ah = 1

func _physics_process(delta):
	global_position.x += -speed * direction

func _on_Enemy2_area_entered(area):
	$explode.play()
	if area.is_in_group("Bullet"):
		$explode.play()
		take_damage(1)
		set_modulate(Color(3,3,3,3))
		emit_signal("add_score")
		$Enemy2Timer.start()
	if area.is_in_group("Player"):
		set_modulate(Color(3,3,3,3))
		$Enemy2Timer.start()

func _on_Enemy2_body_entered(body):
	emit_signal("add_score")
	if body.is_in_group("Bullet"):
		$Sprite.play("squashed")
		take_damage(1)
		die()
		emit_signal("add_score")
	if body.is_in_group("Player"):
		$Enemy2Timer.start()
		set_modulate(Color(3,3,3,3))

func take_damage(damage):
	ah -= damage
	ah -= 1
	$explode.play()
	if ah <= 1:
		die()

func _on_Enemy2Timer_timeout():
	$explode.play()
	take_damage(1)
	queue_free()

func die():
	ah == 0
	$explode.play()

func _on_Sprite_animation_finished():
	queue_free()
	$Enemy2Timer.start()

func _on_sides_checker_body_entered(body):
	queue_free()
	emit_signal("add_score")
	body.take_damage(1)
	if body.is_in_group("Bullet"):
		queue_free()
