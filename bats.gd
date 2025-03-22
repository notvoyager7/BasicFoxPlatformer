extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fox_player_died() -> void:
	for bat in get_children():
		bat.set_process(false)
		
func startup():
	for bat in get_children():
		bat.startup()


func _on_level_1_game_won() -> void:
	for bat in get_children():
		bat.set_process(false)
