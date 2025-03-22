extends StaticBody2D

var speed = randf_range(100, 500)
var in_flight = false
var destination = Vector2(randf_range(50, 1102), randf_range(50, 598))
var velocity = Vector2(speed, 0)
var at_start = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var destination_reached = position.x >= destination.x - 5 and position.x <= destination.x + 5
	
	if destination_reached or at_start:
		in_flight = false
		at_start = false
		
		velocity = Vector2.ZERO # set vel 0
		
		# get new dest
		var new_destination = Vector2(randf_range(50, 1102), randf_range(50, 598))
		destination = new_destination
		destination.x += randf_range(-30, 30)
		destination.y += randf_range(-30, 30)
		
		# wait after reaching dest
		await get_tree().create_timer(1.0).timeout
		
		# update speed
		speed = randf_range(100, 500)
		
		# set new velocity
		velocity = Vector2(speed, 0)
		velocity = velocity.rotated(position.angle_to_point(destination))
			
		# orient animation
		if destination.x < position.x: $AnimatedSprite2D.flip_h = true
		else: $AnimatedSprite2D.flip_h = false
		
		in_flight = true # begin flying again
	
	# fly if in-flight
	if in_flight:
		# flight now prevents overshooting of destination
		var x_dist = destination.x - position.x + 1
		var y_dist = destination.y - position.y + 1
		
		if absf(x_dist) < absf(velocity.x * delta) or absf(y_dist) < absf(velocity.y * delta):
			position = destination
		else:
			position += velocity * delta
	
func startup():
	# reset bat details
	speed = randf_range(100, 500)
	in_flight = false
	destination = Vector2(randf_range(50, 1102), randf_range(50, 598))
	velocity = Vector2(speed, 0)
	at_start = true
	position = $StartPosition.position
	
	# begin processing again
	set_process(true)
	
	# set inititial velocity direction
	velocity = velocity.rotated(position.angle_to_point(destination))
	$AnimatedSprite2D.animation = "flying"
	$AnimatedSprite2D.play()
