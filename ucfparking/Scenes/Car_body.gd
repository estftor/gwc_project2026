extends CharacterBody2D


#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


#func _physics_process(delta: float) -> void:
	# Add the gravity.
#	if not is_on_floor():
#		velocity += get_gravity() * delta

	# Handle jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

#	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction := Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)

#var speed = 300
#var turn_speed = 2.5  # radians per second

#func _physics_process(delta):
	# Left/right rotates the car
#	var turn = Input.get_axis("ui_left", "ui_right")
#	rotation += turn * turn_speed * delta

	# Up/down drives forward/backward in the direction the car faces
#	var move = Input.get_axis("ui_down", "ui_up")
#	velocity = Vector2.UP.rotated(rotation) * move * speed
#	move_and_slide()

var speed = 300
var turn_speed = 2.5   # max radians per second (at full speed)
var min_turn_speed_threshold = 20.0  # below this speed the car can't turn

func _physics_process(delta):
	var move = Input.get_axis("ui_down", "ui_up")
	var turn = Input.get_axis("ui_left", "ui_right")

	# Only turn if the car is actually moving
	var current_speed = velocity.length()
	var speed_factor = clamp(current_speed / speed, 0.0, 1.0)

	# Flip steering when reversing so it feels natural
	var direction_sign = 1.0
	if velocity.dot(Vector2.UP.rotated(rotation)) < 0:
		direction_sign = -1.0

	rotation += turn * turn_speed * speed_factor * direction_sign * delta

	velocity = Vector2.UP.rotated(rotation) * move * speed
	move_and_slide()
	
	#When collision body hits exclamation point, move to minigame
