extends CharacterBody2D


const SPEED = 120.0
const JUMP_VELOCITY = -250.0
@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
		
	if Input.is_action_just_pressed("ui_accept") and velocity.y<15:
		velocity.y = 0.5*JUMP_VELOCITY
		anim.play("attack")
	
	if Input.is_action_just_pressed("ui_down")and is_on_floor_only() :
		velocity.y = 0.5*JUMP_VELOCITY
		velocity.x = SPEED*10
		anim.play("dash")
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h=true
	else :
		get_node("AnimatedSprite2D").flip_h=false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("idle")

	move_and_slide()
