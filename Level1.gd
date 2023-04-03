extends Node2D

func _enter_tree():
	if Checkpoint.last_position:
		$player.global_position = Checkpoint.last_position
func _physics_process(delta):
	if Input.is_action_pressed("reset"):
		if Checkpoint.level ==1:
			get_tree().change_scene("res://Level1.tscn")
		elif Checkpoint.level ==2:
			get_tree().change_scene("res://Level2.tscn")
		elif Checkpoint.level ==3:
			get_tree().change_scene("res://Level3.tscn")
