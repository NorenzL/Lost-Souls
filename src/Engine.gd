extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Signal handler for when another body enters the engine's area.
func _on_Engine_body_entered(body):
	if body.name == "Player":
		# Get the OrbCounter node
		var orb_counter = get_node("/root/OrbCounter")
		
		# Get the number of orbs collected by the player
		var total_orbs_collected = orb_counter.blueOrbsCollected + orb_counter.greenOrbsCollected + orb_counter.redOrbsCollected + orb_counter.yellowOrbsCollected
		
		# Reset the number of collected orbs
		orb_counter.blueOrbsCollected = 0
		orb_counter.greenOrbsCollected = 0
		orb_counter.redOrbsCollected = 0
		orb_counter.yellowOrbsCollected = 0
		
		# Print the total number of orbs collected by the player
		print("Total orbs collected by player:", total_orbs_collected)
