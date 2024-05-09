extends Area2D

# Signal handler for when another body enters the exit area.
func _on_Exit_body_entered(body):
	if body.name == "Player":
		# Get the OrbCounter node
		var orb_counter = get_node("/root/OrbCounter")
		
		# Check if the player has collected 2 orbs
		if orb_counter.totalOrbsCollected() >= 2:
			# Exit the game
			get_tree().quit()
