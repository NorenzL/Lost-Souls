extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _on_Door_body_entered(body):
	if body.name in Global.player_id:  # Check if the entering body is a player
		var player_index = Global.player_id.find(body.name)  # Get the index of the player
		if player_index != -1:
			var required_orb_color = match_player_id_to_orb_color(player_index)
			if required_orb_color != null:
				if OrbCounter.checkRequiredOrbs(required_orb_color, 2):
					print("Player " + str(player_index) + " can exit the game.")
					# Add your exit game logic here
					$AnimationPlayer.play("Door_Open")
				else:
					print("Player " + str(player_index) + " does not have enough orbs to exit.")
			else:
				print("Player " + str(player_index) + " does not have a specific orb color assigned.")
		else:
			print("Player " + body.name + " not found in Global.player_id.")
	else:
		print("A non-player body entered the door area.")

# Function to match player_id index to orb color
func match_player_id_to_orb_color(player_index):
	var orb_colors = ["blue", "green", "red", "yellow"]
	if player_index < len(orb_colors):
		return orb_colors[player_index]
	else:
		return null
