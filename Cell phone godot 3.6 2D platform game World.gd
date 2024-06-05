extends Node2D

var score = 0

func score():
	score += 1
	$HUD/Score.text = " SCORE: " + str(score)
	if score == 44:
		get_tree().change_scene("res://YouWin.tscn")
		score += 1
		get_tree().change_scene("res://YouWin.tscn")
