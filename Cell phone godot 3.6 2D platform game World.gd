extends Node2D

var score = 0

func score():
	$gameover.play()
	score += 1
	$HUD/Score.text = " SCORE " + str(score)
	if score >= 100:
		get_tree().change_scene("res://YouWin.tscn")



func _on_gameover_finished():
	$gameover.stop()
