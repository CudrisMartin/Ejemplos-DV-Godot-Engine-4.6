extends Control

@onready var panel_estado = $UIPrincipal/PanelEstado
@onready var panel_condiciones = $UIPrincipal/PanelCondiciones
@onready var game_over_popup = $UIPrincipal/PopupPanel
@onready var hearts_container = $UIPrincipal/Corazones
@onready var body_node = $CuerpoHumano
@onready var marks_node = $Marcas

@onready var nombre_input = $UIPrincipal/PanelCondiciones/VBoxContainer/NombreCondicion
@onready var zona_input = $UIPrincipal/PanelCondiciones/VBoxContainer/ZonaCondicion
@onready var lista_condiciones = $UIPrincipal/PanelEstado/VBoxContainer/ListaCondiciones

var vida_total = 3
var vida_actual = 3
var condiciones_aplicadas = 0

# Zonas con su posición relativa al cuerpo
var zonas = {
	"Cabeza":    Vector2(0, -150),
	"Pecho":     Vector2(0, -60),
	"Abdomen":   Vector2(0, 20),
	"Brazo izq": Vector2(-80, -40),
	"Brazo der": Vector2(80, -40),
	"Pierna izq":Vector2(-30, 120),
	"Pierna der":Vector2(30, 120),
}

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
	var heart = hearts_container.get_child(vida_actual)
	heart.modulate = Color(0.3, 0.3, 0.3, 0.4)

	# Añadir X en el cuerpo
	var marca = Label.new()
	marca.text = "✕"
	marca.add_theme_font_size_override("font_size", 48)
	marca.modulate = Color.RED
	marca.position = body_node.position + zona_pos - Vector2(15, 24)
	marks_node.add_child(marca)

	# Añadir al listado de estado actual
	var entrada = Label.new()
	entrada.text = "• [%s] %s" % [zona_nombre, nombre]
	lista_condiciones.add_child(entrada)

	condiciones_aplicadas += 1
	nombre_input.text = ""

	if vida_actual <= 0:
		game_over()

func game_over():
	panel_estado.visible = false
	panel_condiciones.visible = false
	game_over_popup.popup_centered()
