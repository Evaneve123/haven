extends CharacterBody2D

@export var spike: TileMapLayer
const SPEED = 250.0
const JUMP_VELOCITY = -300.0
var spawn = Vector2(10,10)
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		var collider = collision.get_collider()
		if collider == spike:
			dead()
	
			
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
func dead():	
	global_position = spawn
