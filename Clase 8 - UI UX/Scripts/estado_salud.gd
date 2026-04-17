extends Control

# Variables declarando paneles, assets y demás
@onready var panel_estado = $UIPrincipal/PanelEstado
@onready var panel_condiciones = $UIPrincipal/PanelCondiciones
@onready var game_over_popup = $UIPrincipal/PopupPanel
@onready var contenedor_corazones = $UIPrincipal/Corazones
@onready var cuerpo_humano = $CuerpoHumano
@onready var nodo_marcas = $Marcas

@onready var nombre_input = $UIPrincipal/PanelCondiciones/VBoxContainer/NombreCondicion
@onready var zona_input = $UIPrincipal/PanelCondiciones/VBoxContainer/ZonaCondicion
@onready var lista_condiciones = $UIPrincipal/PanelEstado/VBoxContainer/ListaCondiciones

# Variables con las vidas totales y condiciones
var vida_total = 3
var vida_actual = 3
var condiciones_aplicadas = 0

# Zonas con su posición relativa al cuerpo
var zonas = {
	"Cabeza":    Vector2(0, -176),
	"Pecho":     Vector2(0, -108),
	"Abdomen":   Vector2(0, -40),
	"Brazo izq": Vector2(-67.1, -67.1),
	"Brazo der": Vector2(-56.4, -56.4),
	"Pierna izq":Vector2(-91.2, -91.2),
	"Pierna der":Vector2(-97.4, -97.4),
}

# Los paneles apareceran desactivados al inicio
func _ready():
	panel_estado.visible = false
	panel_condiciones.visible = false
	game_over_popup.visible = false

	# Llenar el OptionButton con las zonas
	for zona in zonas.keys():
		zona_input.add_item(zona)

	$UIPrincipal/PanelCondiciones/VBoxContainer/Button.pressed.connect(agregar_condicion)
	$UIPrincipal/PopupPanel/VBoxContainer/Button.pressed.connect(func(): game_over_popup.visible = false)

func _process(_delta):
	if Input.is_action_just_pressed("open_estado"):
		panel_estado.visible = !panel_estado.visible
		panel_condiciones.visible = false

	if Input.is_action_just_pressed("open_condiciones"):
		panel_condiciones.visible = !panel_condiciones.visible
		panel_estado.visible = false

func agregar_condicion():
	if vida_actual <= 0:
		return

	var nombre = nombre_input.text.strip_edges()
	if nombre == "":
		nombre = "Sin nombre"

	var zona_nombre = zona_input.get_item_text(zona_input.selected)
	var zona_pos = zonas[zona_nombre]

	# Quitar corazón
	vida_actual -= 1
	var heart = contenedor_corazones.get_child(vida_actual)
	heart.modulate = Color(0.3, 0.3, 0.3, 0.4)

	# Añadir X en el cuerpo
	var marca = Label.new()
	marca.text = "✕"
	marca.add_theme_font_size_override("font_size", 48)
	marca.modulate = Color.RED
	marca.position = cuerpo_humano.position + zona_pos - Vector2(15, 24)
	nodo_marcas.add_child(marca)

	# Añadir al listado de estado actual
	var entrada = Label.new()
	entrada.text = "• [%s] %s" % [zona_nombre, nombre]
	lista_condiciones.add_child(entrada)

	condiciones_aplicadas += 1
	nombre_input.text = ""

	if vida_actual <= 0:
		game_over()

# Funcion que abre el pop-up de Game Over
func game_over():
	panel_estado.visible = false
	panel_condiciones.visible = false
	game_over_popup.popup_centered()
