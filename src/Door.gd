extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

# Called when a body enters the door area.
func _on_Door_body_entered(body):
	# Check if the entering body is a player
	if body.name in Global.player_id:
		# Get the index of the player
		var player_index = Global.player_id.find(body.name)
		if player_index != -1:
			# Get the required orb color for the player
			var required_orb_color = match_player_id_to_orb_color(player_index)
			if required_orb_color != null:
				# Check if the player has enough orbs of the required color
				if OrbCounter.checkRequiredOrbs(required_orb_color, 2):
					print("Player " + str(player_index) + " can exit the game.")
					# Add your exit game logic here
					$AnimationPlayer.play("Door_Open")
				else:
					print("Player " + str(player_index) + " does not have enough orbs to exit.")
		else:
			print("Player " + body.name + " not found in Global.player_id.")
	else:
		print("A non-player body entered the door area.")

# Function to match player_id index to orb color
func match_player_id_to_orb_color(player_index):
	var orb_colors = ["blue", "yellow", "red", "green"]
	if player_index < len(orb_colors):
		return orb_colors[player_index]
	else:
		return null
