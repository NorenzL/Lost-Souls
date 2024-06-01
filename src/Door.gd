extends Area2D

func _on_Door_body_entered(body):
	if Global.player_id.has(body.name):
		var totalOrbsInAltar = OrbCounter.inventory[0] + OrbCounter.inventory[1] + OrbCounter.inventory[2] + OrbCounter.inventory[3]
		var requiredOrbs = 0
		match Global.number_of_players:
			4:
				requiredOrbs = 4
			6:
				requiredOrbs = 6
			8:
				requiredOrbs = 8
			_:
				pass
		
		print("Total orbs in altar:", totalOrbsInAltar)
		print("Required orbs:", requiredOrbs)

		if totalOrbsInAltar >= requiredOrbs:
			print("Players can exit")
			$AnimationPlayer.play("Door_Open")
		else:
			print("Players cannot exit, not enough orbs in the altar")
