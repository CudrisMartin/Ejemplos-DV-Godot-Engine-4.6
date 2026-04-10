extends AnimatableBody2D

@export var seguidor : PathFollow2D

@export var velocidad : int = 500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	seguidor.progress += velocidad*delta
