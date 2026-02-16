class_name Carro
extends PathFollow2D

static var Marcas = {
	0: "Renault",
	1: "F1",
	2: "Toyota",
	3: "Camion"
}

## Atributo publico, cualquier objeto podrá acceder a este.
var marca : int

## Atributo publico con metodo set y get.
var velocidad: int =  500 : 
	set(v): # Establece que la velocidad debe estar entre 100 y 900.
		velocidad = clamp(v,100,900)
	get: # Simplemente devuelve el valor de la variable.
		return velocidad

## Atributo privado, otros objetos no podrán acceder a este, solo él mismo.
var placa : String 

# Atributo publico que le da un color al carro.
var color : Color = Color("ffffffff")

func _ready():
	$Sprite2D.modulate = color
	$Sprite2D.frame = marca

## El movimiento del carro se da segun la propia velocidad del objeto Carro.
func _process(delta):
	progress += velocidad * delta
