extends Control


var player = load("res://src/Player.tscn")
#vars used in ui nodes
onready var multiplayer_config_ui = $multiplayer_configure
onready var server_ip_address = $multiplayer_configure/Server_ip_address

onready var device_ip_address = $CanvasLayer/Device_ip_address

func _ready():
	get_tree().connect("network_peer_connected",self,"_player_connected")
	get_tree().connect("network_peer_disconnected",self, "_player_disconnected")
	get_tree().connect("connected_to_server",self,"_connected_to_server")
	
	#just UI set label text
	device_ip_address.text = Network.ip_address

func _player_connected(id) -> void:
	print("player ", str(id), " has connected")

	instance_player(id)

func _player_disconnected(id) -> void:
	print("player ", str(id), " has disconnected")
	
	if AncientPalace.has_node(str(id)):
		AncientPalace.get_node(str(id)).queue_free()


func _on_Create_Server_pressed():
	multiplayer_config_ui.hide()
	Network.create_server()
	get_tree().change_scene("res://src/AncientPalace.tscn")
	instance_player(get_tree().get_network_unique_id())

func _on_Join_Server_pressed():
	if server_ip_address.text != "":
		multiplayer_config_ui.hide()
		Network.ip_address = server_ip_address.text
		Network.join_server()

func _connected_to_server():
	yield(get_tree().create_timer(0.1),"timeout")
	instance_player(get_tree().get_network_unique_id())

func instance_player (id) -> void:
	var player_instance = Global.instance_node_at_location(player, AncientPalace, Vector2(Rng.generate_X_num(),Rng.generate_Y_num()))
	player_instance.name = str(id)
	player_instance.set_network_master(id)
	
