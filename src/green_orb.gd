extends Area2D

# Signal emitted when the orb is collected

# Flag to track if the orb has been collected
var collected = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $OrbSound.playing == false:
		$OrbSound.play()
	else:
		return
		

func _on_green_orb_body_entered(body):
	if body.name == Global.player_id[3] and OrbCounter.inventory[3]==0:
		body.collect.play()
		OrbCounter.incrementGreenOrbs()
		self.queue_free()



func _on_green_orb_area_entered(area):
	if "_orb" in area.name:
		area.queue_free()
		yield(get_tree().create_timer(4), "timeout")
		OrbSpawner.relocate_orb(area.name)

	if "-power" in area.name:
		area.queue_free()
		yield(get_tree().create_timer(2), "timeout")
		OrbSpawner.relocate_power(area.name)
