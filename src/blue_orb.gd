extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $OrbSound.playing == false:
		$OrbSound.play()
	else:
		return


func _on_blue_orb_body_entered(body):
	# Check if the orb has not been collected yet
	if body.name == Global.player_id[0] && OrbCounter.inventory[0]==0:
		body.collect.play()
		OrbCounter.incrementBlueOrbs()
		self.queue_free()


func _on_blue_orb_area_entered(area):
	if "_orb" in area.name:
		area.queue_free()
		yield(get_tree().create_timer(4), "timeout")
		OrbSpawner.relocate_orb(area.name)
	
	if "-power" in area.name:
		area.queue_free()
		yield(get_tree().create_timer(1), "timeout")
		OrbSpawner.relocate_power(area.name)
