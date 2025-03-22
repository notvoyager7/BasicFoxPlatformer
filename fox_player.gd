extends CharacterBody2D

signal heart_collected
signal jumped
signal died

var in_air = false
var alive = true

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	startup()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if not alive:
		move_and_slide() # does nothing besides move (for falling) if dead
		return

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		emit_signal("jumped")

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	
func _process(delta):
	if is_on_floor(): # tracks if sprite is grounded
		in_air = false
		
	if not alive: return
	
	if position.y >= 648: emit_signal("died")
	
	handle_animation()
	
	var last_collision = get_last_slide_collision()
	if not last_collision == null: handle_collision(last_collision)
		
func handle_jump():
	in_air = true
	$AnimatedSprite2D.animation = "jump"
	
func handle_animation():
	if velocity.x == 0: $AnimatedSprite2D.animation = "idle"
	elif not in_air: $AnimatedSprite2D.animation = "walking"
		
	if velocity.x < 0: $AnimatedSprite2D.flip_h = true
	elif velocity.x > 0: $AnimatedSprite2D.flip_h = false
	
	$AnimatedSprite2D.play()
	
func set_position_starting_position():
	position = $StartingPosition.position


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.name.begins_with("Heart") and alive:
		area.hide()
		area.get_child(1).set_deferred("disabled", true)
		emit_signal("heart_collected")
		
func handle_collision(collision):
	if collision.get_collider().name.begins_with("Bat"): emit_signal("died")
	
func on_death():
	if not alive: return # do nothing if already dead
	
	alive = false
	velocity = Vector2.ZERO
	set_collision_mask_value(1, false) # disables collisions for the player on death
	$AnimatedSprite2D.animation = "death"
	$AnimatedSprite2D.play()
	
func startup():
	position = $StartingPosition.position
	set_collision_mask_value(1, true)
	in_air = false
	alive = true
	$AnimatedSprite2D.animation = "idle"
	if $AnimatedSprite2D.is_flipped_h(): $AnimatedSprite2D.flip_h = true


func _on_level_1_game_won() -> void:
	# disables sprite upon win
	alive = false
	velocity = Vector2.ZERO
	$AnimatedSprite2D.animation = "idle_looping"
	$AnimatedSprite2D.play()
	
