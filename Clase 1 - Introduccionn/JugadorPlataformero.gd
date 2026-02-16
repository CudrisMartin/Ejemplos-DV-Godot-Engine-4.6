extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0

var direction : int

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y > 0:
			$Sprite2D.play("fall")
		else:
			$Sprite2D.play("jump")
	else:
		if velocity.x == 0:
			$Sprite2D.play("idle")
		else:
			$Sprite2D.play("run")

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction != 0:
		$Sprite2D.scale.x = direction

	move_and_slide()
