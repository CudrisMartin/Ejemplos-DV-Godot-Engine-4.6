class_name Item extends PanelContainer

@export var item_name  : String = "Espada"
@export var icon_emoji : String = "⚔️"
@export var damage     : int    = 10
@export var weight     : float  = 2.5
@export var rarity     : String = "Común"

signal item_selected(item_data: Dictionary)

@onready var icon_label  : Label  = $VBox/IconLabel
@onready var name_label  : Label  = $VBox/NameLabel
@onready var click_btn   : Button = $ClickArea

var data : Dictionary = {}

# ---------------------------------------------------------------
func _ready() -> void:
	data = {
		"name"   : item_name,
		"icon"   : icon_emoji,
		"damage" : damage,
		"weight" : weight,
		"rarity" : rarity,
	}

	icon_label.text = icon_emoji
	name_label.text = item_name

	click_btn.pressed.connect(_on_clicked)

	_apply_style()


func _on_clicked() -> void:
	item_selected.emit(data)


func _apply_style() -> void:
	var style = StyleBoxFlat.new()
	style.bg_color        = Color(0.15, 0.15, 0.20, 1.0)
	style.border_width_top    = 2
	style.border_width_bottom = 2
	style.border_width_left   = 2
	style.border_width_right  = 2
	style.border_color    = Color(0.4, 0.4, 0.6, 1.0)
	style.corner_radius_top_left     = 6
	style.corner_radius_top_right    = 6
	style.corner_radius_bottom_left  = 6
	style.corner_radius_bottom_right = 6
	add_theme_stylebox_override("panel", style)


func highlight(on: bool) -> void:
	var style = get_theme_stylebox("panel").duplicate()
	style.border_color = Color(0.9, 0.8, 0.2, 1.0) if on else Color(0.4, 0.4, 0.6, 1.0)
	add_theme_stylebox_override("panel", style)
