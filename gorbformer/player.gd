extends CharacterBody2D

@onready var cloud_particles = $cloud_particles
@onready var dash_sfx = $dash
const SPEED = 4.0
const JUMP_VELOCITY = -200.0
const AIR_FLOAT_VELOCITY = -10.0
var air_dash = 0
var godmode = 0
@onready var tilemap = $"../TileMapLayer"

func place_tile_at_feet():
	var feet_position = global_position + Vector2(0, 16)
	var tile_position: Vector2i = tilemap.local_to_map(feet_position)

	tilemap.set_cell(tile_position, 0, Vector2i(0, 0))
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and godmode == 0:
		velocity += get_gravity() * delta
		
	if is_on_floor():
		air_dash = 1

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# air float thingy.
	if Input.is_action_pressed("jump") and not is_on_floor():
		velocity.y = velocity.y + AIR_FLOAT_VELOCITY
	if Input.is_action_pressed("jump") and godmode == 1:
		velocity.y = -180
	if Input.is_action_pressed("down") and godmode == 1:
		velocity.y = 180
	if not is_on_floor() and godmode == 1:
		velocity.y = move_toward(velocity.y * 0.5, 0, SPEED)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = velocity.x + direction * SPEED
	else:
		velocity.x = move_toward(velocity.x * 0.5, 0, SPEED)
# flip sprite when move right
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	# same for left
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("slow"):
		velocity.x = 0
		velocity.y = 0
	if Input.is_action_just_released("slow") and Input.is_action_pressed("right") and air_dash == 1:
		velocity.x = 270
	if Input.is_action_just_released("slow") and Input.is_action_pressed("left") and air_dash == 1:
		velocity.x = -270
	if Input.is_action_just_released("slow") and Input.is_action_pressed("jump") and air_dash == 1:
		velocity.y = -270
	if Input.is_action_just_released("slow") and Input.is_action_pressed("down") and air_dash == 1:
		velocity.y = 270
	if Input.is_action_just_released("slow") and air_dash == 1:
		air_dash = 0
		cloud_particles.restart()
		cloud_particles.emitting = true
		dash_sfx.play()
	if Input.is_action_just_pressed("godmode"):
		godmode = 1 - godmode
	if Input.is_action_just_pressed("tile") and godmode == 1:
		place_tile_at_feet()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		#Engine.time_scale = 1

	move_and_slide()
