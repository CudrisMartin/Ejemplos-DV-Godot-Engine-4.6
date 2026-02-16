extends PanelContainer

@export var Placa : Label
@export var Marca : Label
@export var Velocidad : Label
@export var color : Label
@export var Regresar : Button

func mostrar_info(c : Carro):
	
	self.Placa.text = c.placa
	self.Marca.text = c.Marcas[c.marca]
	self.Velocidad.text = str(c.velocidad)
	self.color.add_theme_color_override("font_color",c.color)
	self.color.text = "#" + c.color.to_html(false)
	
