extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Speedpower_body_entered(body):
	if body.name in Global.player_id:
		body.collect_power("speed")
		queue_free()


func _on_Speedpower_area_entered(area):
	
	if "-power" in area.name:
		area.queue_free()
		yield(get_tree().create_timer(4), "timeout")
		OrbSpawner.relocate_power(area.name)
