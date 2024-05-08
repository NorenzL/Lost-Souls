extends Area2D

# Signal handler for when another body enters the exit area.
func _on_Exit_body_entered(body):
	if body.name == "Player":
		print("Player has exited the game area")
		var engine_scene = load("res://src/AncientPalace.tscn")
		var engine_instance = engine_scene.instance()
		get_tree().set_root(engine_instance)
