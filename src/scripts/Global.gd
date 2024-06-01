extends Node

# Global variables to manage the game state
var player_master = null  # Master node for players
var player_id = []  # List of player IDs
var number_of_players = 0  # Total number of players
var winner = []  # List to track winners

var ui = null  # Reference to the UI node
var flashlight: bool = true  # Flashlight state (on/off)
var altar = null  # Reference to the Altar node

# Function to instance a node at a specific location within a parent node
func instance_node_at_location(node: Object, parent: Object, location: Vector2) -> Object:
	# Instance the node and set its global position
	var node_instance = instance_node(node, parent)
	node_instance.global_position = location
	return node_instance

# Function to instance a node within a parent node
func instance_node(node: Object, parent: Object) -> Object:
	# Instance the node and add it as a child to the parent node
	var node_instance = node.instance()
	parent.add_child(node_instance)
	return node_instance
