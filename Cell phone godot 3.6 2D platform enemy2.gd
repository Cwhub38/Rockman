extends Area2D
class_name Enemy2

var inout_vector = Vector2.ZERO
var speed = 1
var score = 0
var direction = 1
var hp = 6

func _physics_process(delta):
	global_position.x += -speed * direction

func _on_Enemy2_area_entered(area):
	if area.is_in_group("Bullet"):
		set_modulate(Color(3,3,3,3))
		queue_free()
	if area.is_in_group("Player"):
		set_modulate(Color(3,3,3,3))
		$Enemy2Timer.start()

func _on_Enemy2_body_entered(body):
	if body.is_in_group("Bullet"):
		queue_free()
	if body.is_in_group("Player"):
		$Enemy2Timer.start()
		set_modulate(Color(3,3,3,3))


func _on_Enemy2Timer_timeout():
	queue_free()
