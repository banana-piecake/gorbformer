extends CharacterBody2D


const SPEED = 4.0
const JUMP_VELOCITY = -200.0
const AIR_FLOAT_VELOCITY = -10.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# air float thingy.
	if Input.is_action_pressed("jump") and not is_on_floor():
		velocity.y = velocity.y + AIR_FLOAT_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = velocity.x + direction * SPEED
	else:
		velocity.x = move_toward(velocity.x * 0.5, 0, SPEED)

	move_and_slide()
