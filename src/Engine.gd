extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Signal handler for when another body enters the engine's area.
func _on_Engine_body_entered(body):
	if body.name == "Player":
		# Get the OrbCounter node
		var orb_counter = get_node("/root/OrbCounter")

		# Check if the player has collected 2 orbs
		if orb_counter.totalOrbsCollected() >= 2:
			# Print the total number of orbs collected by the player
			print("Total orbs collected by player:", orb_counter.totalOrbsCollected())
