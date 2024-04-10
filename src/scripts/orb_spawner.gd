extends Node2D

#HOW TO USE:
	#Just call script in _ready() to Use once
	#check script name in project/ project settings/ AutoLoad 
	

# Number of objects to spawn
var NUM_OBJECTS = Rng.number_of_players 



func spawn_objects():
	#iterates based on the number of players
	for i in range(NUM_OBJECTS):
		# Generate a random position within the spawn region
		var spawn_position = Vector2(
			Rng.generate_X_num(),
			Rng.generate_Y_num()
		)
		
		# Instantiate and add object to scene
		#ORB INSTANTIATION
		
		#spawned object variable
		var new_object = load("res://blue_orb.tscn").instance()
		
		#orb colors instantiation
		var blue_orb = load("res://blue_orb.tscn").instance()
		var yellow_orb = load("res://yellow_orb.tscn").instance()
		var red_orb = load("res://red_orb.tscn").instance()
		var green_orb = load("res://green_orb.tscn").instance()
		
		
		
		#THINK OF A BETTER AND MORE FLEXIBLE ALGORITHM FOR THIS THAT ROLLS INFINITELY OR UNTIL GOAL IS FULFILLED
		if i == 1 or i == 2:
			new_object = blue_orb
			new_object.position = spawn_position
		if i == 3 or i == 4:
			new_object = yellow_orb
			new_object.position = spawn_position
		if i == 5 or i == 6:
			new_object = red_orb
			new_object.position = spawn_position
		if i == 7 or i == 8:
			new_object = green_orb
			new_object.position = spawn_position
		
		add_child(new_object)




















