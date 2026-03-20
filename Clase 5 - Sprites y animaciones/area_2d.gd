extends Area2D

func _on_body_entered(body):
	if body.name == "Elara":
		body.puede_interactuar = true
		get_node("../Label").show()

func _on_body_exited(body):
	if body.name == "Elara":
		body.puede_interactuar = false
		get_node("../Label").hide()
