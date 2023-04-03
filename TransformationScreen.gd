extends CanvasLayer
func _ready():
	$AnimationPlayer.play("fade_to_normal")
	
func change_scene(target: String) -> void:
	
	$AnimationPlayer.play("fade_to_black")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene(target)
	$AnimationPlayer.play("fade_to_normal")
	


func _on_AnimationPlayer_animation_finished(_anim_name):
	pass 
