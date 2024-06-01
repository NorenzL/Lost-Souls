extends Node

var blueOrbsCollected: int = 0
var greenOrbsCollected: int = 0
var redOrbsCollected: int = 0
var yellowOrbsCollected: int = 0
var inventory = [0, 0, 0, 0]

func incrementBlueOrbs():
	blueOrbsCollected += 1
	inventory[0] += 1
	print("Blue orbs collected: ", blueOrbsCollected)

func incrementGreenOrbs():
	greenOrbsCollected += 1
	inventory[3] += 1
	print("Green orbs collected: ", greenOrbsCollected)

func incrementRedOrbs():
	redOrbsCollected += 1
	inventory[2] += 1
	print("Red orbs collected: ", redOrbsCollected)

func incrementYellowOrbs():
	yellowOrbsCollected += 1
	inventory[1] += 1
	print("Yellow orbs collected: ", yellowOrbsCollected)
