extends Camera2D

# fetch player body
onready var player = get_node("/root/AncientPalace/Player")



func _process(delta):
	position.x = player.position.x
	position.y = player.position.y
	OS.set_window_size(Vector2(1600,720))
