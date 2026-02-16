extends CharacterBody2D

##Este Script hace que el jugador se mueva, viene por defecto al momento de añadirle un Script a
##un CharacterBody2D.

##Constantes de rapidez de movimiento y de salto.
const SPEED = 350.0
const JUMP_SPEED = -500.0

##Obtiene la gravedad especificada en el proyecto para que se sincronice con la de los RigidBody2d.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Añade la gravedad.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Maneja el salto.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_SPEED

	# Obtiene la dirección de la entrada, y maneja el movimiento y desaceleración del cuerpo.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#Permite que se mueva el cuerpo.
	move_and_slide()
