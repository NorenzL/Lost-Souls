extends Area2D

# Signal handler for when a body enters the door area
func _on_Door_body_entered(body):
	# Check if the body is a player by verifying its name in the global player_id list
	if Global.player_id.has(body.name):
		# Get the reference to the altar from the Global script
		var altar = Global.altar
		
		# Check if the altar reference is valid
		if altar == null:
			print("Altar node not found")
			return

		# Get the total number of orbs placed in the altar
		var totalOrbsInAltar = altar.orbPlaced
		var requiredOrbs = 0

		# Determine the required number of orbs based on the number of players
		match Global.number_of_players:
			4:
				requiredOrbs = 4
			6:
				requiredOrbs = 6
			8:
				requiredOrbs = 8
			_:
				pass  # For any number of players not explicitly handled, no orbs are required

		# Print the total orbs in the altar and the required orbs for debugging
		print("Total orbs in altar:", totalOrbsInAltar)
		print("Required orbs:", requiredOrbs)

		# Check if the total orbs in the altar meet or exceed the required orbs
		if totalOrbsInAltar >= requiredOrbs:
			print("Players can exit")
			$AnimationPlayer.play("Door_Open")
		else:
			print("Players cannot exit, not enough orbs in the altar")
