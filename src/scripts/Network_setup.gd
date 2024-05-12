extends Control


var player = preload("res://src/Player.tscn")
#vars used in ui nodes
onready var multiplayer_config_ui = $multiplayer_configure
onready var username_text_edit = $multiplayer_configure/Username_text_edit

onready var device_ip_address = $CanvasLayer/Device_ip_address
onready var start_game = $CanvasLayer/Start_game

func _ready():
	get_tree().connect("network_peer_connected",self,"_player_connected")
	get_tree().connect("network_peer_disconnected",self, "_player_disconnected")
	get_tree().connect("connected_to_server",self,"_connected_to_server")
	
	#just UI set label text
	device_ip_address.text = Network.ip_address

	if get_tree().network_peer != null:
		pass
	else:
		start_game.hide()
		 
func _process(delta):
	if get_tree().get_network_connected_peers().size() >= 1 and get_tree().is_network_server():
		print(get_tree().get_network_connected_peers().size())
		start_game.show()
	else:
		start_game.hide()
		
func _player_connected(id) -> void:
	print("player ", str(id), " has connected")

	instance_player(id)

func _player_disconnected(id) -> void:
	print("player ", str(id), " has disconnected")
	
	if Persistent_nodes.has_node(str(id)):
		Persistent_nodes.get_node(str(id)).queue_free()


func _on_Create_Server_pressed():
	if username_text_edit.text != "":
		Network.current_player_username = username_text_edit.text
		multiplayer_config_ui.hide()
		Network.create_server()
		instance_player(get_tree().get_network_unique_id())
	

func _on_Join_Server_pressed():
	if username_text_edit.text != "":
		multiplayer_config_ui.hide()
		username_text_edit.hide()
		
		Global.instance_node(load("res://src/Server_browser.tscn"), self)

func _connected_to_server():
	yield(get_tree().create_timer(0.1),"timeout")
	instance_player(get_tree().get_network_unique_id())

func instance_player (id) -> void:
	var player_instance = Global.instance_node_at_location(player, Persistent_nodes, Vector2(rand_range(100,700),0))
	player_instance.name = str(id)
	player_instance.set_network_master(id)
	


func _on_Start_game_pressed():
	rpc("spawn_orbs")
	rpc("switch_to_game")

sync func switch_to_game():
	get_tree().change_scene("res://src/AncientPalace.tscn")

sync func spawn_orbs():
	OrbSpawner.spawn_objects()
