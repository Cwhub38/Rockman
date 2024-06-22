extends KinematicBody2D
class_name Fireball

var velocity= Vector2()
var direction = 1
const speed = 800

func _ready():
	velocity.x = speed * direction 

func _physics_process(delta):
	
	if is_on_wall():
		queue_free()
	
	velocity = move_and_slide(velocity,Vector2.UP)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
