extends KinematicBody2D
class_name boss

signal add_score
signal enemy_died
var ep = 10
var input_vector = Vector2.ZERO
var speed = 1
var velocity = Vector2(-1,0)
var score = 0
var direction = 1

func _physics_process(delta):
	$AnimationPlayer.play("move")

func take_damage(damage):
	$explode.play()
	ouch()
	$AnimationPlayer.play("death")
	ep -= damage
	ep -= 1
	$AnimationPlayer.play("death")
	if ep <= 1:
		emit_signal("enemy_died")
		$AnimationPlayer.play("death")

func ouch():
	emit_signal("add_score")
	$AnimationPlayer.play("death")
	$explode.play()
	take_damage(1)
	emit_signal("add_score")

func _on_sides_checker_body_entered(body):
	if body.get_collision_layer() == 1:
		body.take_damage(1)
		body.loadhearts()
		emit_signal("died")
		emit_signal("add_score")
		$Sprite.play("squashed")

func enemy_died():
	ep == 0
	if ep <= 1:
		$AnimationPlayer.play("death")
		$Sprite.play("squashed")
		set_modulate(Color(3,1,1,1))

func _on_Sprite_animation_finished(body):
	body.queue_free()
	queue_free()
	if ep <= 1:
		enemy_died()
		body.queue_free()
		queue_free()
		$dieTimer.start()

func _on_dieTimer_timeout():
		get_tree().change_scene("res://YouWin.tscn")

func _on_AnimationPlayer_animation_finished(death):
	$dieTimer.start()
	emit_signal("add_score")

func _on_sides_checker_area_entered(area):
	ep -= 1
	if ep <= 1:
		enemy_died()
		$explode.play()
		emit_signal("add_score")
		$Sprite.play("squashed")
