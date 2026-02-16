extends Node2D

var input_jugador : bool = false
var recibe_input : bool = false
var recibio_input : bool = false
var fin_juego : bool = false

func recibir_input(valor : bool):
	recibe_input = valor

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and !recibio_input:
		if recibe_input:
			input_jugador = true
		recibio_input = true
	
	if event.is_action_pressed("ui_cancel"):
		$AnimationPlayer.play("RESET")
		input_jugador = false
		recibe_input = false
		recibio_input = false
		fin_juego = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"RESET":
			$AnimationPlayer.play("Preparacion")
		"Preparacion":
			$AnimationPlayer.play("Ataque")
		"Ataque":
			if input_jugador:
				$AnimationPlayer.play("Victoria")
			else:
				$AnimationPlayer.play("Derrota")
		"Derrota", "Victoria":
			fin_juego = true
