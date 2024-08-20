extends Node2D

var score = 0

func score():
	score += 1
	$HUD/Score.text = " SCORE: " + str(score)

func ready():
	$AnimatedSprite.play("a")

func _on_door_body_entered(area):
	if is_in_group("Player"):
		get_tree().change_scene("res://YouWin.tscn")
