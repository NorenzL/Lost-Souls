extends Area2D

# Variables to track which player is interacting and how many orbs have been placed in the altar
var playerHolder: int
var orbPlaced: int = 0
var requiredOrbs = 0
onready var door = get_parent().get_node("Door")
# Called when the node enters the scene tree for the first time.
func _ready():
	# Register this instance of the altar in the Global script for easy access
	Global.altar = self  
	door.hide()

# Signal handler for when a body enters the altar area
func _on_Altar_body_entered(body):
	# Check if the body is a player by verifying its name in the global player_id list
	if Global.player_id.has(body.name):
		# Find the player's position in the player_id list
		playerHolder = Global.player_id.bsearch(body.name)
		
		match Global.number_of_players:
			4:
				requiredOrbs = 4
			6:
				requiredOrbs = 6
			8:
				requiredOrbs = 8
			_:
				pass  # For any number of players not explicitly handled, no orbs are required
				
		# Match the player's position to manage the corresponding orb inventory
		match playerHolder:
			0:
				if OrbCounter.inventory[0] > 0:
					# Decrement the player's orb inventory and increment the altar's orb count
					OrbCounter.inventory[0] -= 1
					orbPlaced += 1
					print(orbPlaced)
			1:
				if OrbCounter.inventory[1] > 0:
					OrbCounter.inventory[1] -= 1
					orbPlaced += 1
					print(orbPlaced)
			2:
				if OrbCounter.inventory[2] > 0:
					OrbCounter.inventory[2] -= 1
					orbPlaced += 1
					print(orbPlaced)
			3:
				if OrbCounter.inventory[3] > 0:
					OrbCounter.inventory[3] -= 1
					orbPlaced += 1
					print(orbPlaced)
			_:
				pass  # In case the playerHolder value doesn't match any of the expected positions
			
		if orbPlaced == requiredOrbs:
			door.show()
			$AnimationPlayer.play("Activating")
