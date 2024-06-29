extends KinematicBody2D
class_name Fireball

var velocity = Vector2()
var direction = 1
const speed = 800

func _ready():
	velocity.x = speed * direction 

func _physics_process(delta):
	velocity = move_and_slide(velocity,Vector2.UP)
	if is_on_wall():
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_fireball_body_entered(body):
	if body.is_in_group("enemies"):
		emit_signal("add_score")
		$exploded.play()
		queue_free()

func _on_fireball_area_entered(area):
	if is_in_group("enemies"):
		emit_signal("add_score")
		area.take_damage(1)
		$exploded.play()
