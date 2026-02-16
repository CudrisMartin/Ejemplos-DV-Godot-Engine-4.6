extends Control

signal enviar_info_carro(placa : String, marca : int, velocidad : float, color : Color)
signal carro_seleccionado(placa : String)

@export var SelectorMarca : OptionButton
@export var SelectorVelocidad : HSlider
@export var SelectorColor : ColorPickerButton
@export var ListadoCarros : ItemList

@onready var ejemplo = $PanelContainer/MarginContainer/VBoxContainer/SeccionFinal

func _generar_placa() -> String:
	var retorno : String
	
	for i in range(6):
		if i > 2:
			retorno += str(randi_range(0,9))
		else:
			retorno += char(randi_range(65,90))
	
	return retorno

func crear_carro():
	
	var placa := _generar_placa()
	
	enviar_info_carro.emit(
		placa,
		SelectorMarca.selected,
		float(SelectorVelocidad.value),
		SelectorColor.get_picker().color
	)
	
	ListadoCarros.add_item(placa)

func _on_lista_carros_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if mouse_button_index == MOUSE_BUTTON_LEFT:
			carro_seleccionado.emit(ListadoCarros.get_item_text(index))
