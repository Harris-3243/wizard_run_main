
extends Node2D
export var speed = 1


func _ready():
	
	$AnimationPlayer.playback_speed = speed
	$AnimationPlayer.play("move")
	pass
	


