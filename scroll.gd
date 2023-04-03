extends Area2D
var size = 0
var playing = false
func _ready():
	pass


func _on_scroll_body_entered(body):
	if body.name == "player":
		Checkpoint.collect= true
		$AudioStreamPlayer2D.play()
		$AnimationPlayer.play("clicked")
		playing = true
		#$Sprite.visible = false
		#$Timer.start()
		

func _physics_process(_delta):
	self.scale.y = abs(sin(size))+3
	self.scale.x = abs(sin(size))+3
	size += 0.03
	if !$AnimationPlayer.is_playing() and playing:
		queue_free()
	


func _on_Timer_timeout():
	queue_free()
