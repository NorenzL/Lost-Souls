extends Camera2D

var target_player = null
# fetch player body
#onready var player = get_node("/root/AncientPalace/Player")

func _ready():
	target_player = Global.player_master

func _process(delta):
	if Global.player_master != null:
		global_position = Global.player_master.global_position
	

