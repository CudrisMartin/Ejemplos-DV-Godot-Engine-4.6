extends "res://Clase 6/Plataforma/Jugador.gd"

func _ready():
	##Haremos que la barra de progreso mida la velocidad vertical del jugador.
	$ProgressBar.max_value = 2*abs(JUMP_SPEED)

func _process(delta):
	$ProgressBar.value = 500 - velocity.y ##Cambia el valor de la barra de progreso.
	
	if Input.is_action_just_pressed("ui_select"):
		$AudioStreamPlayer.play() ##Reproduce el audio de Salto.
