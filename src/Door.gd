extends Area2D

var exit : bool = false
# Called when the node enters the scene tree for the first time.
func _process(delta):
	if Altar.orbPlaced == Global.number_of_players:
		$AnimationPlayer.play("Door_Open")
		exit = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

# Called when a body enters the door area.
func _on_Door_body_entered(body):
	# Check if the entering body is a player
	if Global.player_id.has(body.name) && exit == true:
		Global.player_id.append(body.name)
		body.queue_free()
		print(body.name,"Won the Game")
		# Get the index of the player
	else:
		print("A non-player body entered the door area.")
