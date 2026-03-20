extends CharacterBody2D

@export var velocidad = 200.0
var puede_interactuar = false
@onready var escena = preload("res://Clase 5 - Sprites y animaciones/Anima.tscn")

func _physics_process(_delta):
	# 1. Obtener la dirección de movimiento (Ejes X e Y)
	var direccion = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# 2. Aplicar movimiento
	velocity = direccion * velocidad
	move_and_slide()

	# 3. CONTROL DE ANIMACIONES
	actualizar_animacion(direccion)
	
func _input(event):
	if puede_interactuar and event.is_action_pressed("interactuar"):
		velocity = Vector2.ZERO
		
		get_tree().change_scene_to_packed(escena)

func actualizar_animacion(dir):
	# Si el personaje se está moviendo
	if dir.length() > 0:
		if abs(dir.x) > abs(dir.y):
			# Movimiento horizontal predominante
			if dir.length() > 0:
				$AnimatedSprite2D.play("idle_right")
				if dir.x < 0:
					$AnimatedSprite2D.flip_h = true
				elif dir.x >0:
					$AnimatedSprite2D.flip_h = false
			else:
				$AnimatedSprite2D.play("idle")
		else:
			# Movimiento vertical predominante
			if dir.y > 0:
				$AnimatedSprite2D.play("idle_down")
			else:
				$AnimatedSprite2D.play("idle_up")
	else:
		# Si está quieto, volvemos a la animación de espera (Idle)
		$AnimatedSprite2D.play("idle")
