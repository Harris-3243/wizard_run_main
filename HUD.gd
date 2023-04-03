extends CanvasLayer

var is_timer_running = true
var time: float = 0
var timeleft: int = 30
var coins = 0
var scrolls = 0



func _ready():
	#set all coins and scrolls to 0
	coins = Checkpoint.save_coins
	Checkpoint.change_coins = 0
	
	scrolls = Checkpoint.save_scroll
	Checkpoint.change_scroll = 0
	
	
	$Coins.text = String(coins)
	$scrolls.text = String(scrolls)
	
	
func update():
	
	#calls the hud to put on the labels
	$Coins.text = String(coins)
	$scrolls.text = String(scrolls)
	
	

func _on_coin1_coin_collected():
	#collision detection with coins
	coins = coins + 1
	Checkpoint.change_coins += 1
	
	update()

func _process(delta: float) -> void:
	time += delta
	if Checkpoint.collect:
		Checkpoint.change_scroll +=1
		scrolls += 1
		Checkpoint.collect= false
		update()
		
	if coins >= 5:
		#scroll-coin conversion
		$scrolls.get_font("font").size = 60
		#$AudioStreamPlayer2D.play()
		Checkpoint.change_scroll +=1
		scrolls +=1
		coins -=5
		#Checkpoint.save_coins = 0
		Checkpoint.change_coins = 0
		update()
	if(int(time) == 1):
		timeleft -= 1
		time = 0
	if timeleft == 0:
		#detecting if time ==0
		if Checkpoint.level == 1:
			get_tree().change_scene("res://Level1.tscn")
		elif Checkpoint.level == 2:
			get_tree().change_scene("res://Level2.tscn")
		else:
			get_tree().change_scene("res://Level3.tscn")
			
	if Checkpoint.change == 30:
		timeleft = 30
		Checkpoint.change = 0
		
	if $scrolls.get_font("font").size != 40:
		$scrolls.get_font("font").size -= 1
	
	$time.text = ("Time: " + str(timeleft))
	$time2.text = str(Checkpoint.time_string)
