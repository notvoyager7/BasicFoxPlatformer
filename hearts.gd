extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hud_play() -> void:
	for heart in get_children():
		heart.show()
		heart.get_child(1).set_deferred("disabled", false)
