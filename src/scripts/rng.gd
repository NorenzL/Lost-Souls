extends Node

#HOW TO USE:
	#Just call script in _ready() to Use once
	#check script name in project/ project settings/ AutoLoad 



#DEPENDS ON THE SIZE OF THE MAP YUNG SIZE NG SPAWN AREA
const SPAWN_REGION_MIN = Vector2(-1936, -2088)
const SPAWN_REGION_MAX = Vector2(2928, 2757)

#SEPARATE RAMDOM NUMBER GENERATORS FOR X AND Y COORDINATES
var X_coordinate_rng = RandomNumberGenerator.new()
var Y_coordinate_rng = RandomNumberGenerator.new()



#RANDOM NUMBER GENERATOR SEEDS GENERATOR PARA MAG IBA YUNG NEXT NUMBER


#GENERATE RANDOM X COORDINATE (BASED ON SPAWN REGION MAX AND MIN)
func generate_X_num ():
	
	X_coordinate_rng.seed = OS.get_unix_time() %1000   #added randomization lang pero kahit talaga wala na neto
	var rand_num = X_coordinate_rng.randi_range(SPAWN_REGION_MIN.x,SPAWN_REGION_MAX.x)
	X_coordinate_rng.seed += 1   
				   #PLUS 1 SA SEED PARA MAG BAGO NEXT NUMBER 
	return rand_num


#GENERATE RANDOM Y COORDINATE (BASED ON SPAWN REGION MAX AND MIN)
func generate_Y_num ():
	Y_coordinate_rng.seed = OS.get_unix_time()  %1000               #added randomization lang pero kahit talaga wala na neto
	var rand_num = Y_coordinate_rng.randi_range(SPAWN_REGION_MIN.y,SPAWN_REGION_MAX.y)
	Y_coordinate_rng.seed += 1     
				  #PLUS 1 SA SEED PARA MAG BAGO NEXT NUMBER 
	return rand_num
