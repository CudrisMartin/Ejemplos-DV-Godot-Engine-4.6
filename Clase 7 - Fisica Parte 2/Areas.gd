extends Node2D


func _process(delta):
	if $RayCast2D.is_colliding():
		
		$ColorRect.color = Color(0,1,0)
	else:
		$ColorRect.color = Color(1,1,1)
	
	if $ShapeCast2D.is_colliding():
		print($ShapeCast2D.get_collider(0).name)
		$ColorRect2.color = Color(0,0,1)
	else:
		$ColorRect2.color = Color(1,1,1)


func _on_rojo_body_entered(body):
	body.modulate = Color(1,0,0)

func _on_verde_body_entered(body):
	body.modulate = Color(0,1,0)
	body.jump_velocity = -800
	body.jump()

func _on_azul_body_entered(body):
	body.modulate = Color(0,0,1)

func _on_limpiar_body_entered(body):
	body.modulate = Color(1,1,1)

func _on_verde_body_exited(body):
	body.jump_velocity = -600
