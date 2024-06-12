extends KinematicBody2D
class_name boss

signal add_score
signal enemy_died
var ep = 10
var inout_vector = Vector2.ZERO
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
	emit_signal("enemy_died")
	$AnimationPlayer.play("death")
	if ep <= 0:
		emit_signal("enemy_died")
		$AnimationPlayer.play("death")

func ouch():
	emit_signal("add_score")
	$AnimationpPlayer.play("death")
	$explode.play()
	take_damage(1)
	emit_signal("add_score")

func _on_sides_checker_body_entered(body):
	if body.get_collision_layer() == 1:
		$explode.play()
		body.take_damage(1)
		body.loadhearts()
		emit_signal("died")
		emit_signal("add_score")
		$Sprite.play("squashed")
		set_modulate(Color(0.3,0.3,0.3,0.3))
		enemy_died()
		$AnimationPlayer.play("death")
		$dieTimer.start()

func enemy_died():
	ep == 0
	if ep <= 0:
		$AnimationPlayerp.play("death")
		$Sprite.play("squashed")
		set_modulate(Color(3,1,1,1))
		get_tree().change_scene("res://YouWin.tscn")
		$dieTimer.start()

func _on_Sprite_animation_finished(body):
	body.queue_free()
	queue_free()
	if ep <= 0:
		enemy_died()
		body.queue_free()
		queue_free()
		$dieTimer.start()

func _on_dieTimer_timeout():
	ep -= 1
	if ep <= 1:
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
	if ep <= 1:
		$dieTimer.start()
