extends Control


var player = preload("res://src/Player.tscn")
#vars used in ui nodes
onready var multiplayer_config_ui = $multiplayer_configure
onready var username_text_edit = $multiplayer_configure/VBoxContainer/Username_text_edit

onready var logo = $UI/Logo
onready var device_ip_address = $UI/Device_ip_address
onready var disc = $UI/HBoxContainer/Disconnect_Server
onready var start_game = $UI/HBoxContainer/Start_game


func _ready():
	get_tree().connect("network_peer_connected",self,"_player_connected")
	get_tree().connect("network_peer_disconnected",self, "_player_disconnected")
	get_tree().connect("connected_to_server",self,"_connected_to_server")
	
	#just UI set label text
	device_ip_address.text = Network.ip_address

	if get_tree().network_peer != null:
		pass
	else:
		disc.hide()
		start_game.hide()
		 
func _process(delta):
	
	if get_tree().get_network_connected_peers().size() >= 1 and get_tree().is_network_server():
		start_game.show()
	else:
		start_game.hide()
		
func _player_connected(id) -> void:
	print("player ", str(id), " has connected")

	instance_player(id)

func _player_disconnected(id) -> void:
	print("player ", str(id), " has disconnected")
	
	if Persistent_nodes.has_node(str(id)):
		Persistent_nodes.get_node(str(id)).username_text_instance.queue_free()
		Persistent_nodes.get_node(str(id)).queue_free()
		
		var temp = Global.player_id.bsearch(str(id))
		Global.player_id.erase(str(id))
		Global.number_of_players -=2
		Global.player_id.resize(Global.number_of_players/2)
		#	for n in range(Global.player_id.size()):
		#		if n == temp:
		#			if n+1 >= Global.player_id.size():
		#				Global.player_id.resize(Global.player_id.size() - 1)
		#			Global.player_id[n] = Global.player_id[n+1]

func _on_Create_Server_pressed():
	$click.play()
	if username_text_edit.text != "":
		#Network.current_player_username = username_text_edit.text
		multiplayer_config_ui.hide()
		disc.show()
		logo.show()
		Network.create_server()
		instance_player(get_tree().get_network_unique_id())
	

func _on_Join_Server_pressed():
	$click.play()
	if username_text_edit.text != "":
		multiplayer_config_ui.hide()
		username_text_edit.hide()
		
		Global.instance_node(load("res://src/Server_browser.tscn"), self)

func _connected_to_server():
	yield(get_tree().create_timer(0.1),"timeout")
	disc.show()
	logo.show()
	instance_player(get_tree().get_network_unique_id())

func instance_player (id) -> void:
	var player_instance = Global.instance_node_at_location(player, Persistent_nodes, Vector2(rand_range(100,700),0))
	player_instance.name = str(id)
	Global.player_id.append(player_instance.name)
	Global.number_of_players += 2
	Global.alive_players += 2
	print (Global.number_of_players)
	player_instance.set_network_master(id)
	player_instance.username = username_text_edit.text

sync func _on_Start_game_pressed():
	$click.play()
	#rpc("switch_to_game")
	rpc("get_scene")
	

	
func _on_Disconnect_Server_pressed():
	$click.play()
	for child in Persistent_nodes.get_children():
		if child.is_in_group("Net"):
			child.queue_free()
	Network.reset_network_connection()
	disc.hide()
	logo.hide()
	Global.player_id.resize(0)
	Global.number_of_players = 0
	get_tree().change_scene("res://src/Network_setup.tscn")

sync func switch_to_game():
	#if Global.number_of_players == 4:
		#get_scene()
	#if Global.number_of_players == 6:
	get_scene()
	#if Global.number_of_players == 8:
		#get_scene()
		
sync func get_scene():
	var arr = [1,2,3,4]
	var rng = RandomNumberGenerator.new()
	rng.seed = OS.get_unix_time()
	var choice = rng.randi_range(1,arr.size())
	print ("num: " ,rng)
	if choice == 1:
		if Global.number_of_players == 4:
			get_tree().change_scene("res://src/AncientPalace(2-1).tscn")
		if Global.number_of_players == 6:
			get_tree().change_scene("res://src/AncientPalace(3-1).tscn")
		if Global.number_of_players == 8:
			get_tree().change_scene("res://src/AncientPalace(4-1).tscn")
	if choice == 2:
		if Global.number_of_players == 4:
			get_tree().change_scene("res://src/AncientPalace(2-2).tscn")
		if Global.number_of_players == 6:
			get_tree().change_scene("res://src/AncientPalace(3-2).tscn")
		if Global.number_of_players == 8:
			get_tree().change_scene("res://src/AncientPalace(4-2).tscn")
	if choice == 3:
		if Global.number_of_players == 4:
			get_tree().change_scene("res://src/AncientPalace(2-3).tscn")
		if Global.number_of_players == 6:
			get_tree().change_scene("res://src/AncientPalace(3-3).tscn")
		if Global.number_of_players == 8:
			get_tree().change_scene("res://src/AncientPalace(4-3).tscn")
	if choice == 4:
		if Global.number_of_players == 4:
			get_tree().change_scene("res://src/AncientPalace(2-4).tscn")
		if Global.number_of_players == 6:
			get_tree().change_scene("res://src/AncientPalace(3-4).tscn")
		if Global.number_of_players == 8:
			get_tree().change_scene("res://src/AncientPalace(4-4).tscn")
sync func spawn_orbs():
		#OrbSpawner.spawn_objects()
		pass
	
sync func check_orbs():
	print(OrbSpawner.orbs.values())

func _on_Instruction_pressed():
	$click.play()
	$UI/Instruct.show()

func _on_ExitInstruct_pressed():
	$click.play()
	$UI/Instruct.hide()
