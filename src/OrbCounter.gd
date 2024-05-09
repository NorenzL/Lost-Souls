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

func totalOrbsCollected() -> int:
	return blueOrbsCollected + greenOrbsCollected + redOrbsCollected + yellowOrbsCollected
