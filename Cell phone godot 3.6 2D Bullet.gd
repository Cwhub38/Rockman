extends KinematicBody2D
class_name Bullet

var velocity= Vector2()
var direction = 1
const speed = 800

func _ready():
	velocity.x = speed * direction

func _physics_process(delta):
	
	if is_on_wall():
		queue_free()
		if is_in_group("enemies"):
			queue_free()
	
	velocity = move_and_slide(velocity,Vector2.UP)
