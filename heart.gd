extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startup()

func startup():
	$AnimatedSprite2D.set_deferred("disabled", false)
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
