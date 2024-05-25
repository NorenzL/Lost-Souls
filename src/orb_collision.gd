extends Area2D




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var overlap = get_overlapping_areas()
	for node in overlap:
		
		if "power" in node.name:
			OrbSpawner.relocate_power(node.name)
		elif "_orb" in node.name:
			print ("Delete orb in: ",node.position, "  name: ",node.name)
			node.queue_free()
			OrbSpawner.relocate_orb(node.name)
		
