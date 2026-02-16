extends Node

func recuperar_jugador(body):
	$Mundo/Tutoriales/RL_Salvacion.show()
	$Mundo/JugadorPlataformero.global_position = $Mundo/Escenario/Recuperacion.global_position
