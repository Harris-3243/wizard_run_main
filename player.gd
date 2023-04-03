extends KinematicBody2D
export (PackedScene) var dustScene
enum States {AIR = 1, FLOOR, LADDER, WALL }
var state = States.AIR
var velocity = Vector2.ZERO
var direction = 1
const SPEED = 375
const JUMPFORCE = -950
const GRAVITY = 40
var coins = 0
onready var coyote_timer = $CoyoteTimer
var possible  = true
export var boomScene : PackedScene
var hit = false

func _physics_process(_delta):
	var was_on_floor = is_on_floor()
	if was_on_floor and not is_on_floor():
		coyote_timer.start()
	match state:
		States.AIR:
			if is_on_floor() or not coyote_timer.is_stopped():
				state = States.FLOOR
				continue
			elif is_near_wall():
				state = States.WALL
				continue
			
			$Sprite.play("air")
			
			if $jump.is_stopped():
				if Input.is_action_pressed("right"):
					velocity.x = SPEED
					$Sprite.flip_h = false
				elif Input.is_action_pressed("left"):
					velocity.x = -SPEED
					$Sprite.flip_h = true
				elif Input.is_action_just_pressed("pound"):
					
					
					velocity.y += SPEED *3.5
				else:
					velocity.x = lerp(velocity.x, 0, 0.2)
				if possible and! Input.is_action_pressed("right") and! Input.is_action_pressed("left") and Input.is_action_just_pressed("dash"):
					var dust = dustScene.instance()
					get_parent().add_child(dust)
					dust.position = self.position
					velocity.x = SPEED * 8 * direction
					possible = false
			set_direction()
			move_and_fall(false)
			
		States.FLOOR:
			
			#this is the jump functions, this will make sure that you are on the floor and then it will make it so that you can jump
			possible = true
			if Input.is_action_just_pressed("jump"):
				var dust = dustScene.instance()
				get_parent().add_child(dust)
				dust.position = self.position
				dust.position.y += 25
				if not $Sprite.flip_h:
					dust.scale.y = -1
				else:
					dust.scale.y = 1
			#this makes the running function
			if not is_on_floor():
				state = States.AIR
			if Input.is_action_pressed("right"):
				velocity.x = SPEED
				$Sprite.play("walk")
				$Sprite.flip_h = false
			elif Input.is_action_pressed("left"):
				velocity.x = -SPEED
				$Sprite.play("walk")
				$Sprite.flip_h = true
			else:
				$Sprite.play("idle")
				velocity.x = lerp(velocity.x, 0, 0.2)
			if Input.is_action_just_pressed("jump"):
				velocity.y = JUMPFORCE
				$SoundJump.play()
				state = States.AIR
			set_direction()
			move_and_fall(false)
		States.WALL:
			if is_on_floor():
				state = States.FLOOR
				continue
			elif not is_near_wall():
				state = States.AIR
				continue
			$Sprite.play("wall")
			if(Input.is_action_just_pressed("jump")):
				
				velocity.x = 300 * -direction
				velocity.y = JUMPFORCE * 1
				if direction == 1:
					$Sprite.flip_h = true
				else:
					$Sprite.flip_h = false
				
				$SoundJump.play()
				$jump.start()
				state = States.AIR
			move_and_fall(true)
	
	
func set_direction():
	direction = 1 if not $Sprite.flip_h else -1
	$WallChecker.rotation_degrees = 90* -direction
	
	
	
	
func is_near_wall():
	return $WallChecker.is_colliding()
	

	
	
func move_and_fall(slow_fall: bool):
	velocity.y += GRAVITY
	if slow_fall:
		velocity.y = clamp(velocity.y,JUMPFORCE,300)
	
	velocity = move_and_slide(velocity,Vector2.UP)


func _on_fallzone_body_entered(_body):
	if Checkpoint.level == 1:
		get_tree().change_scene("res://Level1.tscn")
	elif Checkpoint.level == 2:
		get_tree().change_scene("res://Level2.tscn")
	else:
		get_tree().change_scene("res://Level3.tscn")
func bounce():
	velocity.y = JUMPFORCE * 0.7
	
func hit(var _enemyposx):
	if !hit:
		hit= false
		var boom = boomScene.instance()
		get_parent().add_child(boom)
		boom.position = self.position
		$Sprite.visible = false
	#set_modulate(Color(1,0.3,0.3,0.4))
	#velocity.y = JUMPFORCE * 0.5
	
	#if position.x < enemyposx:
		#velocity.x = -800
	#else:
		#velocity.x = 800
		Input.action_release("left")
		Input.action_release("right")
	
		$Timer.start()
		$SoundHit.play()
	
	
	


func _on_Timer_timeout():
	if Checkpoint.level == 1:
		get_tree().change_scene("res://Level1.tscn")
	elif Checkpoint.level == 2:
		get_tree().change_scene("res://Level2.tscn")
	else:
		get_tree().change_scene("res://Level3.tscn")
