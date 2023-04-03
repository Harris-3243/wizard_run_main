extends Area2D
var hit_bx = true

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if Checkpoint.save_scroll < 20:
		if body.name == "player":
			Checkpoint.level += 1
			Checkpoint.last_position = null
			Checkpoint.save_coins = Checkpoint.save_coins + Checkpoint.change_coins
			Checkpoint.change_coins = 0
			set_collision_mask_bit(0, false)
			Checkpoint.save_scroll = Checkpoint.save_scroll + Checkpoint.change_scroll
			if Checkpoint.save_coins >= 5:
				Checkpoint.save_coins -= 5
			Checkpoint.change_scroll = 0
			if Checkpoint.level == 1:
				TransformationScreen.change_scene("res://Level1.tscn")
			elif Checkpoint.level == 2:
				TransformationScreen.change_scene("res://Level2.tscn")
			elif Checkpoint.level == 3:
				TransformationScreen.change_scene("res://Level3.tscn")
			else:
				TransformationScreen.change_scene("res://loser.tscn")
	else:
		TransformationScreen.change_scene("res://winner.tscn")
		
		
			
