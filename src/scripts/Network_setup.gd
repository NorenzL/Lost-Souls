extends Control

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

func _player_disconnected(id) -> void:
	print("player ", str(id), " has disconnected")

func _on_create_server_pressed():
	multiplayer_config_ui.hide()
	Network.create_server()
	
func on_join_server_pressed():
	if server_ip_address.text != "":
		multiplayer_config_ui.hide()
		Network.ip_address = server_ip_address.text
		Network.join_server()


func _on_Create_Server_pressed():
	multiplayer_config_ui.hide()
	Network.create_server()


func _on_Join_Server_pressed():
	if server_ip_address.text != "":
		multiplayer_config_ui.hide()
		Network.ip_address = server_ip_address.text
		Network.join_server()
