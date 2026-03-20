extends Control

@onready var anim = get_node("../../AnimationPlayer2")
@onready var opciones = %Opciones

var paso_actual = 0 

func _ready():
	if opciones:
		opciones.hide()
	reproducir_paso()

func _input(event):
	# Si presionas espacio y los botones no están visibles
	if event.is_action_pressed("ui_accept") and not opciones.visible:
		# Solo avanzamos si la animación actual ya terminó de mostrarse
		if not anim.is_playing():
			paso_actual += 1
			reproducir_paso()

func reproducir_paso():
	match paso_actual:
		0:
			anim.play("saludo 1")
		1:
			anim.play("saludo 2")
		2:
			anim.play("saludo_3")
		3:
			anim.play("Pregunta1")
			opciones.show()

func activar_botones():
	opciones.show()
	opciones.z_index = 20
	opciones.modulate.a = 1.0
	print("Botones visibles ahora")
	
# --- SEÑALES DE LOS BOTONES ---

func _on_opcion_1_pressed(): # SI (Flor Feliz)
	anim.play("final_bueno")
	await anim.animation_finished
	finalizar_juego()

func _on_opcion_2_pressed(): # NO (Flor Triste)
	anim.play("final_malo")
	await anim.animation_finished
	finalizar_juego()

func finalizar_juego():
	
	await get_tree().create_timer(2.0).timeout
	get_tree().quit() # Cierra el juego
