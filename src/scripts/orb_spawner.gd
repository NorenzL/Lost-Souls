extends Node2D

#HOW TO USE:
	#Just call script in _ready() to Use once
	#check script name in project/ project settings/ AutoLoad 
	

# Number of objects to spawn
#var NUM_OBJECTS = Rng.number_of_players 

var orbs = {"blue_orb" : 0,
			"yellow_orb": 0,
			"red_orb": 0,
			"green_orb": 0}

var all_spawned = false

func spawn_objects():
	orb_spawn(Rng.number_of_players,"blank_orb")


func orb_spawn(number_of_players : int ,color : String):
	#iterates based on the number of players
	for i in range(number_of_players + 1):
		# Generate a random position within the spawn region
		var spawn_position = Vector2(
			Rng.generate_X_num(),
			Rng.generate_Y_num()
		)
		#ORB INSTANTIATION
		#spawned object variable
		var new_object = load("res://src/blue_orb.tscn").instance()
		
		#orb colors instantiation
		var blue_orb = load("res://src/blue_orb.tscn").instance()
		var yellow_orb = load("res://src/yellow_orb.tscn").instance()
		var red_orb = load("res://src/red_orb.tscn").instance()
		var green_orb = load("res://src/green_orb.tscn").instance()
		
		
		#CHANGE ORB COLOR
		#THINK OF A BETTER AND MORE FLEXIBLE ALGORITHM FOR THIS THAT ROLLS INFINITELY OR UNTIL GOAL IS FULFILLED
		if i == 0 and all_spawned:
			match color:
				"blue_orb":
					new_object = blue_orb
				"yellow_orb":
					new_object = yellow_orb
				"red_orb":
					new_object = red_orb
				"green_orb":
					new_object = green_orb
			orbs[color] += 1
			new_object.position = spawn_position
		
		if i == 1 or i == 2:
			new_object = blue_orb
			orbs.blue_orb += 1
			new_object.position = spawn_position
			
		if i == 3 or i == 4:
			new_object = yellow_orb
			orbs.yellow_orb += 1
			new_object.position = spawn_position
			
		if i == 5 or i == 6:
			new_object = red_orb
			orbs.red_orb += 1
			new_object.position = spawn_position
			
		if i == 7 or i == 8:
			new_object = green_orb
			orbs.green_orb += 1
		new_object.position = spawn_position
			
		print ("Orb ",i," spawned: ", new_object.name, " in ", new_object.position)
		
		add_child(new_object)
	all_spawned = true
	print ("All orbs spawned")


#Vector2(-310, -2737) ------ MIN SPAWN REGION
#Vector2(4510, 1840) ------------ MAX SPAWN REGION
func relocate_orb(orb : String):
	
	var new_text = ""
	for chars in orb:
		if not int(chars)  and chars != "@" and chars != "0":
			new_text += chars
			
	if orbs[new_text] <= 2 and orbs[new_text] > 0  :
		orbs[new_text] -= 1
		print ("rolling: ",new_text)
		OrbSpawner.orb_spawn(0,str(new_text))
	




	

  #
















