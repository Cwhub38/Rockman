extends KinematicBody2D
class_name Bullet

var velocity= Vector2()
var direction = 1
const speed = 800

func _ready():
		velocity.x = speed * direction

func _physics_process(delta):
	velocity = move_and_slide(velocity,Vector2.UP)
	
	if is_on_wall():
		queue_free()
		if is_in_group("enemies"):
			queue_free()
		if is_in_group("enemies"):
			queue_free()
	
		velocity = move_and_slide(velocity,Vector2.UP)

func _on_bullet_body_entered(body):
	if is_in_group("enemies"):
		emit_signal("add_score")
		$exploded.play()
		queue_free()

func _on_bullet_area_entered(area):
	if is_in_group("enemies"):
		emit_signal("add_score")
		$exploded.play()
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
