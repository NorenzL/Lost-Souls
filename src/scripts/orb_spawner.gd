extends Node2D

#HOW TO USE:
	#Just call script in _ready() to Use once
	#check script name in project/ project settings/ AutoLoad 
var orb_colors = ["blue_orb","yellow_orb","red_orb","green_orb"]
var power_types = ["Light-power" ,"Speed-power","Life-power"]
var relocate = false
#controller dictionary for orbs 
export var orbs = {"blue_orb" : 0,
			"yellow_orb": 0,
			"red_orb": 0,
			"green_orb": 0}
			
var powers = {"Light-power" : 0,
			"Speed-power": 0,
			"Life-power": 0}

#checks if the initial spawns are done 

func spawn_objects():
	print ("spawning orbs")
	for i in range (Global.number_of_players/2):
			
			for j in range (2):

				OrbSpawner.orb_spawn(orb_colors[i])
				yield(get_tree().create_timer(2), "timeout") 
				
	yield(get_tree().create_timer(20), "timeout")
	 
	print ("spawning powers")
	for i in range (3):
			
			for j in range (2):

				OrbSpawner.power_spawn(power_types[i])
				yield(get_tree().create_timer(2), "timeout") 
	

func power_spawn(power : String):
		
		var spawn_position = Vector2(
			Rng.generate_X_num(),
			Rng.generate_Y_num()
		)
		
		#power instantiation
		var new_object = load("res://src/Light-power.tscn").instance()
		
		var light_power = load("res://src/Light-power.tscn").instance()
		var speed_power = load("res://src/Speed-power.tscn").instance()
		var life_power = load("res://src/Life-power.tscn").instance()
		
		if powers[power] <=2:
			match power:
				"Light-power":
					new_object = light_power
				"Speed-power":
					new_object = speed_power
				"Life-power":
					new_object = life_power
			powers[power] += 1
			new_object.position = spawn_position

			print ("Power spawned: ", new_object.name, " in ", new_object.position, "\n")
			add_child(new_object)
			yield(get_tree().create_timer(1), "timeout")
			print(powers.keys(), " ", powers.values(), "\n")
		else:
			print("POWER NUMBER EXCEEDS NOT SPAWNED")
	
sync func orb_spawn(color : String):
	#iterates based on the number of players
		
	# Generate a random position within the spawn region
	var spawn_position = Vector2(
		Rng.generate_X_num(),
		Rng.generate_Y_num()
	)
	#ORB INSTANTIATION
	#spawned object variable (template is just blue orb so it won't cause errors)
	var new_object = load("res://src/blue_orb.tscn").instance()
	#orb colors instantiation
	var blue_orb = load("res://src/blue_orb.tscn").instance()
	var yellow_orb = load("res://src/yellow_orb.tscn").instance()
	var red_orb = load("res://src/red_orb.tscn").instance()
	var green_orb = load("res://src/green_orb.tscn").instance()
	#CHANGE ORB COLOR
	#THINK OF A BETTER AND MORE FLEXIBLE ALGORITHM FOR THIS THAT ROLLS INFINITELY OR UNTIL GOAL IS FULFILLED
	if orbs[color] <= 2:
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
		new_object.global_position = spawn_position
		
		print ("Orb spawned: ", new_object.name, " in ", new_object.position, "\n")
		add_child(new_object)
		yield(get_tree().create_timer(1), "timeout") 
		print(orbs.keys(), " ", orbs.values(), "\n")
		
	else : 
		print("ORB NUMBER EXCEEDS NOT SPAWNED")
		




#Vector2(-310, -2737) ------ MIN SPAWN REGION
#Vector2(4510, 1840) ------------ MAX SPAWN REGION

#USED IF ORB SPAWNS OVERLAPPING A PLATFORM
func relocate_orb(orb : String):
	relocate = true
	#removes the '@', '0', and numbers in the orb name
	# these occur when there are multiple orb spawns in the map
	# the naming is like orb, orb1, orb2, orb3, ...
	
	var new_text = ""
	for chars in orb:
		if not int(chars)  and chars != "@" and chars != "0":
			new_text += chars
	
	#this makes sure that the orbs that will spawn for each color are only 2 
	if orbs[new_text] <= 2 and orbs[new_text] > 0  :
		orbs[new_text] -= 1
		print ("rolling: ",new_text)
		yield(get_tree().create_timer(5), "timeout") 
		OrbSpawner.orb_spawn(str(new_text))

sync func relocate_power(power : String):
	
	#removes the '@', '0', and numbers in the orb name
	# these occur when there are multiple orb spawns in the map
	# the naming is like orb, orb1, orb2, orb3, ...
	
	var new_text = ""
	for chars in power:
		if not int(chars)  and chars != "@" and chars != "0":
			new_text += chars
	
	#this makes sure that the orbs that will spawn for each color are only 2 
	if powers[new_text] <= 2 and powers[new_text] > 0  :
		powers[new_text] -= 1
		print ("rolling: ",new_text)
		yield(get_tree().create_timer(5), "timeout") 
		OrbSpawner.power_spawn(str(new_text))
