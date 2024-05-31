extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_yellow_orb_body_entered(body):
	if body.name == Global.player_id[1] and OrbCounter.inventory[1]==0:
		OrbCounter.incrementYellowOrbs()
		self.queue_free()


func _on_yellow_orb_area_entered(area):
	if "_orb" in area.name:
		area.queue_free()
		yield(get_tree().create_timer(4), "timeout")
		OrbSpawner.relocate_orb(area.name)

	if "-power" in area.name:
		area.queue_free()
		yield(get_tree().create_timer(4), "timeout")
		print (area.name)
		OrbSpawner.relocate_power(area.name)
