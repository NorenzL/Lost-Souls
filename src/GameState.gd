extends Node

var orbsCollected: int = 0
var gameRunning: bool = true

func _ready():
	pass

func resetGame():
	# Reset the number of collected orbs
	orbsCollected = 0
	# Set the game state to running
	gameRunning = true

func exitGame():
	# Set the game state to not running
	gameRunning = false
