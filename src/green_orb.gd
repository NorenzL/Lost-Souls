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
	pass
		

func _on_green_orb_body_entered(body):
	if body.name == Global.player_id[3]:
		OrbCounter.incrementGreenOrbs()
		self.queue_free()



func _on_green_orb_area_entered(area):
	if "_orb" in area.name:
		area.queue_free()
		#yield(get_tree().create_timer(1), "timeout")
		OrbSpawner.relocate_orb(area.name)

