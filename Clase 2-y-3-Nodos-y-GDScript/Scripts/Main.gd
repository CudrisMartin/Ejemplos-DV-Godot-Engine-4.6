extends Control

const ItemScene    = preload("res://Escenas/Item.tscn")
const MAX_SLOTS    = 16

@onready var grid_container : GridContainer  = $MarginContainer/HBox/Left/Grid
@onready var add_button     : Button         = $MarginContainer/HBox/Left/TopBar/AddButton
@onready var clear_button   : Button         = $MarginContainer/HBox/Left/TopBar/ClearButton
@onready var count_label    : Label          = $MarginContainer/HBox/Left/TopBar/CountLabel
@onready var stat_icon      : Label          = $MarginContainer/HBox/Right/StatsPanel/Margin/VBox/IconLabel
@onready var stat_name      : Label          = $MarginContainer/HBox/Right/StatsPanel/Margin/VBox/NameLabel
@onready var stat_rarity    : Label          = $MarginContainer/HBox/Right/StatsPanel/Margin/VBox/RarityLabel
@onready var stat_damage    : Label          = $MarginContainer/HBox/Right/StatsPanel/Margin/VBox/DamageLabel
@onready var stat_weight    : Label          = $MarginContainer/HBox/Right/StatsPanel/Margin/VBox/WeightLabel
@onready var hint_label     : Label          = $MarginContainer/HBox/Right/StatsPanel/Margin/VBox/HintLabel

@onready var item_creator   : Window         = $ItemCreator

var items_in_inventory : Array = []


func _ready() -> void:
	add_button.pressed.connect(_on_add_pressed)
	clear_button.pressed.connect(_on_clear_pressed)

	item_creator.item_confirmed.connect(_on_item_confirmed)

	_show_empty_stats()
	_update_count_label()


func _on_add_pressed() -> void:
	if items_in_inventory.size() >= MAX_SLOTS:
		count_label.text = "¡Inventario lleno!"
		return
	item_creator.reset()
	item_creator.popup_centered()


func _on_item_confirmed(item_data: Dictionary) -> void:
	var new_item = ItemScene.instantiate()

	new_item.item_name  = item_data["name"]
	new_item.icon_emoji = item_data["icon"]
	new_item.damage     = item_data["damage"]
	new_item.weight     = item_data["weight"]
	new_item.rarity     = item_data["rarity"]

	new_item.item_selected.connect(_on_item_selected)
	grid_container.add_child(new_item)
	items_in_inventory.append(new_item)
	_update_count_label()


func _on_item_selected(item_data: Dictionary) -> void:
	stat_icon.text   = item_data["icon"]
	stat_name.text   = item_data["name"]
	stat_rarity.text = "✨ Rareza: " + item_data["rarity"]
	stat_damage.text = "⚔️  Daño:   " + str(item_data["damage"])
	stat_weight.text = "⚖️  Peso:   " + str(item_data["weight"]) + " kg"
	hint_label.text  = ""


func _on_clear_pressed() -> void:
	for item in items_in_inventory:
		item.queue_free()
	items_in_inventory.clear()
	_show_empty_stats()
	_update_count_label()


func _show_empty_stats() -> void:
	stat_icon.text   = "❓"
	stat_name.text   = "Ningún ítem"
	stat_rarity.text = ""
	stat_damage.text = ""
	stat_weight.text = ""
	hint_label.text  = "Haz clic en un slot\npara ver sus stats"


func _update_count_label() -> void:
	count_label.text = "%d / %d slots" % [items_in_inventory.size(), MAX_SLOTS]
