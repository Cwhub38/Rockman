extends KinematicBody2D
class_name destroyer

signal enemy_died
signal add_score
var ep = 10

func _physics_process(_delta):
		$AnimationPlayer.play("move")

func take_damage(damage):
	ouch()
	$AnimationPlayer.play("death")
	ep -= damage
	ep -= 1
	if Bullet:
		emit_signal("add_score")
	if ep <= 1:
		emit_signal("enemy_died")
		emit_signal("add_score")

func ouch():
	$AnimationPlayer.play("death")
	$explode.play()
	set_modulate(Color(1,0.3,0.3,0.3))

func _on_destroyer_body_entered(body):
	if body.is_in_group("Bullet"):
		emit_signal("add_score")
		take_damage(1)
	if body.is_in_group("Fireball"):
		emit_signal("add_score")
		take_damage(1)
	if ep <= 1:
		$Sprite.play("explode")
	if body.get_collision_layer() == 1:
		get_tree().change_scene("res://GameOver.tscn")
		body.take_damage(1)
		emit_signal("enemy_died")
		emit_signal("add_score")
		$Sprite.play("squashed")
		$timetodie.start()

func _on_timetodie_timeout():
	set_modulate(Color(1,1,1,1))
	emit_signal("add_score")
	$Sprite.play("death")
	$AnimationPlayer.play("move")

func _on_Sprite_animation_finished():
	queue_free()
	emit_signal("add_score")

func enemy_died():
	ep == 0
	if ep == 0:
		$Sprite.play("death")

func _on_AnimationPlayer_animation_finished(death):
	$timetodie.start()

func _on_destroyer_area_entered(area):
	if area.is_in_group("player"):
		take_damage(1)
		area.loadhearts()
