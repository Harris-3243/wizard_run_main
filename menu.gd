extends Control

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		TransformationScreen.change_scene("res://main menu.tscn")
	
	if Input.is_action_just_pressed("right"):
		get_tree().change_scene("res://How_to_play.tscn")
		
	if Input.is_action_just_pressed("left"):
		get_tree().change_scene("res://controlls.tscn")

		



	
