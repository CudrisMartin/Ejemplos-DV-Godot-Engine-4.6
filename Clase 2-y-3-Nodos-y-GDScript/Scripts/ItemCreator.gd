extends Window

const ICON_OPTIONS = [
	"⚔️", "🗡️", "🪓", "🏹", "🪄", "🛡️", "🔨", "🔱",
	"🗺️", "💎", "🧪", "📜", "🪙", "🔑", "🧲", "👑",
	"🌟", "🔥", "❄️", "⚡", "🌿", "💀", "🐉", "🎯",
]

signal item_confirmed(item_data: Dictionary)

@onready var name_input    : LineEdit    = $Margin/VBox/NameInput
@onready var icon_preview  : Label       = $Margin/VBox/PreviewRow/IconPreview
@onready var icon_grid     : GridContainer = $Margin/VBox/Scroll/IconGrid
@onready var damage_spin   : SpinBox     = $Margin/VBox/DamageSpin
@onready var weight_spin   : SpinBox     = $Margin/VBox/WeightSpin
@onready var rarity_option : OptionButton = $Margin/VBox/RarityOption
@onready var confirm_btn   : Button      = $Margin/VBox/ConfirmButton

var selected_icon : String = "⚔️"


func _ready() -> void:
	close_requested.connect(func(): hide())
	confirm_btn.pressed.connect(_on_confirm_pressed)
	_build_icon_grid()


func _build_icon_grid() -> void:
	for emoji in ICON_OPTIONS:
		var btn = Button.new()
		btn.text = emoji
		btn.add_theme_font_size_override("font_size", 20)
		btn.custom_minimum_size = Vector2(42, 42)
		icon_grid.add_child(btn)
		btn.pressed.connect(_on_icon_selected.bind(emoji))


func _on_icon_selected(emoji: String) -> void:
	selected_icon = emoji
	icon_preview.text = emoji


func _on_confirm_pressed() -> void:
	var item_name = name_input.text.strip_edges()
	if item_name.is_empty():
		item_name = "Ítem sin nombre"

	item_confirmed.emit({
		"name"   : item_name,
		"icon"   : selected_icon,
		"damage" : int(damage_spin.value),
		"weight" : snappedf(weight_spin.value, 0.1),
		"rarity" : rarity_option.get_item_text(rarity_option.selected),
	})
	hide()


func reset() -> void:
	name_input.text = ""
	selected_icon = "⚔️"
	icon_preview.text = "⚔️"
	damage_spin.value = 10
	weight_spin.value = 2.5
	rarity_option.selected = 0
