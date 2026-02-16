extends CharacterBody2D

@export_range(0,10,0.1) var amplitud : float = 1
@export_range(0,10,0.1) var fase : float = 1

@export var vel_x : float = 100
@export var vel_y : float = 100

func _physics_process(delta: float) -> void:
	var t = 0.001*Time.get_ticks_msec()
	velocity.y = vel_y
	velocity.x = sin(t*fase)*amplitud*vel_x
	print(str(position.x)+"; "+str(t))
	move_and_slide()
