extends Node

var blueOrbsCollected: int = 0
var greenOrbsCollected: int = 0
var redOrbsCollected: int = 0
var yellowOrbsCollected: int = 0

func _ready():
	pass

func incrementBlueOrbs():
	blueOrbsCollected += 1
	print("Blue orbs collected: ", blueOrbsCollected)

func incrementGreenOrbs():
	greenOrbsCollected += 1
	print("Green orbs collected: ", greenOrbsCollected)

func incrementRedOrbs():
	redOrbsCollected += 1
	print("Red orbs collected: ", redOrbsCollected)

func incrementYellowOrbs():
	yellowOrbsCollected += 1
	print("Yellow orbs collected: ", yellowOrbsCollected)

# Function to check if the player has collected the required number of orbs of a specific color
func checkRequiredOrbs(color: String, requiredCount: int) -> bool:
	match color:
		"blue":
			return blueOrbsCollected >= requiredCount
		"green":
			return greenOrbsCollected >= requiredCount
		"red":
			return redOrbsCollected >= requiredCount
		"yellow":
			return yellowOrbsCollected >= requiredCount
		_:
			return false
