extends Node2D

##Este Script solo sirve para mover la plataforma flotante y restablece la posición del Jugador en
##caso de caer fuera de la pantella.

#Posición inicial del Jugador
@onready var pos_inicial : Vector2 = $Jugador.global_position

##Función process, se llama en cada cuadro.
func _process(delta):
	_mover_plataforma(delta)

#Mueve la plataforma flotante
func _mover_plataforma(delta):
	$Path2D/PathFollow2D.progress += 500*delta

#Cuando el jugador cae fuera de la pantalla, se vuelve a ubicar en la pantalla visible, ignorar
#Hasta Clase 7 - Areas
func _on_area_2d_body_entered(body):
	$Jugador.global_position = pos_inicial
