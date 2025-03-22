extends Node

signal game_won

const TOTAL_HEARTS = 5
var num_hearts

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Setup HUD
	num_hearts = 0
	$HUD.total_hearts = TOTAL_HEARTS

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if num_hearts == TOTAL_HEARTS:
		$CollectHeart.stop() # stop collect heart sound
		
		set_process(false) # stop processing on win
		
		emit_signal("game_won")
		$Music.stop()
		$WinIntro.play()
		
		await $WinIntro.finished
		$WinOutro.play()

func start_level():
	set_process(true)
	
	# Setup HUD
	num_hearts = 0
	$HUD.total_hearts = TOTAL_HEARTS
	
	$WinIntro.stop()
	$WinOutro.stop()
	
	$Music.play()


func _on_fox_player_heart_collected() -> void:
	num_hearts += 1
	$HUD.num_hearts = num_hearts
	$CollectHeart.play()


func _on_fox_player_died() -> void:
	$Music.stop()
	$GameOver.play()
