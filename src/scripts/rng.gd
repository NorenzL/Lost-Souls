extends Node

#HOW TO USE:
	#Just call script in _ready() to Use once
	#check script name in project/ project settings/ AutoLoad 

#NUMBER OF PLAYERS -- TO BE FIXED KAPAG NASA SPRINT NA YUNG LOBBY FUNCTION PARA	MADETERMINE ILAN YUNG LALARO
#MAX 4 PLAYERS I THINK
var number_of_players = 8


#DEPENDS ON THE SIZE OF THE MAP YUNG SIZE NG SPAWN AREA
const SPAWN_REGION_MIN = Vector2(-310, -2737)
const SPAWN_REGION_MAX = Vector2(4510, 1840)

#SEPARATE RAMDOM NUMBER GENERATORS FOR X AND Y COORDINATES
var X_coordinate_rng = RandomNumberGenerator.new()
var Y_coordinate_rng = RandomNumberGenerator.new()

#RANDOM NUMBER GENERATOR SEEDS GENERATOR PARA MAG IBA YUNG NEXT NUMBER
var x_rng_seed = X_coordinate_rng.seed
var y_rng_seed = Y_coordinate_rng.seed

#GENERATE RANDOM X COORDINATE (BASED ON SPAWN REGION MAX AND MIN)
func generate_X_num ():
	X_coordinate_rng.randomize()                    #added randomization lang pero kahit talaga wala na neto
	var rand_num = X_coordinate_rng.randi_range(SPAWN_REGION_MIN.x,SPAWN_REGION_MAX.x)
	x_rng_seed += y_rng_seed                      #PLUS 1 SA SEED PARA MAG BAGO NEXT NUMBER 
	return rand_num


#GENERATE RANDOM Y COORDINATE (BASED ON SPAWN REGION MAX AND MIN)
func generate_Y_num ():
	Y_coordinate_rng.randomize()                 #added randomization lang pero kahit talaga wala na neto
	var rand_num = Y_coordinate_rng.randi_range(SPAWN_REGION_MIN.y,SPAWN_REGION_MAX.y)
	y_rng_seed += x_rng_seed                    #PLUS 1 SA SEED PARA MAG BAGO NEXT NUMBER 
	return rand_num
