extends CanvasLayer

signal play

var num_hearts
var total_hearts = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HeartsCollected.text = ": " + "0" + " / " + str(total_hearts)
	$HeartsCollected.hide()
	$HeartIcon.hide()
	
	$Message.text = "Brave the Dark Forest"
	$Message.show()
	
	$PlayButton.text = "Play"
	$PlayButton.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fox_player_heart_collected() -> void:
	$HeartsCollected.text = ": " + str(num_hearts) + " / " + str(total_hearts)


func _on_fox_player_died() -> void:
	$Message.text = "Game Over"
	$Message.show()
	
	$PlayButton.text = "Play Again"
	$PlayButton.show()


func _on_play_button_pressed() -> void:
	$Message.hide()
	$PlayButton.hide()
	$ForestBackground.hide()
	
	$HeartsCollected.text = ": " + "0" + " / " + str(total_hearts)
	$HeartsCollected.show()
	$HeartIcon.show()
	
	$Description.hide()
	
	emit_signal("play")


func _on_level_1_game_won() -> void:
	$Message.text = "You Win!"
	$Message.show()
	
	$PlayButton.text = "Play Again"
	$PlayButton.show()
