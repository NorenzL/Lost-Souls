extends Node

# Variables to track the number of orbs collected for each color
var blueOrbsCollected: int = 0
var greenOrbsCollected: int = 0
var redOrbsCollected: int = 0
var yellowOrbsCollected: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Increment the number of blue orbs collected and print the updated count.
func incrementBlueOrbs():
	blueOrbsCollected += 1
	print("Blue orbs collected: ", blueOrbsCollected)

# Increment the number of green orbs collected and print the updated count.
func incrementGreenOrbs():
	greenOrbsCollected += 1
	print("Green orbs collected: ", greenOrbsCollected)

# Increment the number of red orbs collected and print the updated count.
func incrementRedOrbs():
	redOrbsCollected += 1
	print("Red orbs collected: ", redOrbsCollected)

# Increment the number of yellow orbs collected and print the updated count.
func incrementYellowOrbs():
	yellowOrbsCollected += 1
	print("Yellow orbs collected: ", yellowOrbsCollected)

# Function to check if the player has collected the required number of orbs of a specific color.
# Returns true if the required number of orbs of the specified color have been collected, false otherwise.
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
