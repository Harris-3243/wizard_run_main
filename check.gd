extends Area2D
var entered = false
func _ready():
	$Sprite.play("first")
	pass

func _on_checkpoint_body_entered(_body):
	if not entered:
		$AudioStreamPlayer2D.play()
		entered = true
		Checkpoint.save_coins = Checkpoint.save_coins + Checkpoint.change_coins
		Checkpoint.change_coins = 0
		Checkpoint.save_scroll = Checkpoint.save_scroll + Checkpoint.change_scroll
		if Checkpoint.save_coins >=5:
			Checkpoint.save_coins -=5
		Checkpoint.change_scroll = 0
			
		
			
	$Sprite.play("second")
	Checkpoint.last_position = global_position
	Checkpoint.change = 30
	
	
	
	
	
		
	
