extends KinematicBody2D

const ping = preload('res://src/ping.tscn')
const username_text = preload('res://src/username_text.tscn')
export var speed: int = 200
export var jumpForce: int = 600
export var gravity: int = 800

var velocity: Vector2 = Vector2(0,0)
var grounded: bool = false
var isPinging: bool = false
var pingNode: KinematicBody2D = null

var username setget username_set
var username_text_instance = null


puppet var puppet_position = Vector2() setget puppet_position_set
puppet var puppet_velocity = Vector2()
puppet var puppet_username = "" setget puppet_username_set

onready var sprite = $Sprite
onready var timer = $Timer
onready var cdTimer = $cdTimer
onready var lightTimer = $lightTImer


onready var flashlight = $flashlight
onready var tween = $Tween
onready var anim = $PlayerAnimate


onready var canvasModulate = null

var isDead: bool = false
var isImmune: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	
	username_text_instance = Global.instance_node_at_location(username_text,Persistent_nodes,global_position)
	username_text_instance.player_following = self
	
	yield(get_tree(),"idle_frame")
	if is_network_master():
		Global.player_master = self
		
	
		
func _process(delta: float) -> void:
	if username_text_instance != null:
		username_text_instance.name = "username "+name	
	
	if Global.number_of_players >= 2 and str(get_network_master()) == Global.player_id[0]:
		 anim.modulate = Color(0,0,1)
	elif Global.number_of_players >= 4 and str(get_network_master()) == Global.player_id[1]:
		 anim.modulate = Color(1,1,0)
	elif Global.number_of_players >= 6 and str(get_network_master()) == Global.player_id[2]:
		 anim.modulate = Color(1,0,0)
	elif Global.number_of_players == 8 and str(get_network_master()) == Global.player_id[3]:
		 anim.modulate = Color(0,1,0)
	#else:
		
	
	if Global.flashlight == false:
		flashlight.visible = false
	else:
		flashlight.visible = true
	
	if is_network_master():
		velocity.x = 0
		# Left and right movement
		if Input.is_action_pressed("ui_left"):
			velocity.x -= speed
			anim.flip_h = true
			flashlight.rotation_degrees = -266.4
			
		if Input.is_action_pressed("ui_right"):
			velocity.x += speed
			anim.flip_h = false
			flashlight.rotation_degrees = -94.7
		if (velocity.x !=0):
			anim.play("Walk")
		else:
			anim.play("Idle")
		
		velocity = move_and_slide(velocity, Vector2.UP)
		
		velocity.y += gravity * delta
		# jump
		if Input.is_action_pressed("ui_up") and is_on_floor():
			velocity.y -= jumpForce
		
		if Input.is_action_pressed("ping") and !isPinging:
			isPinging = true
			ping()
	else:
		if not tween.is_active():
			move_and_slide(puppet_velocity * speed)
		if puppet_velocity.x < 0:
			anim.flip_h = true
			anim.play("Walk")
			flashlight.rotation_degrees = -266.4
		elif puppet_velocity.x > 0:
			anim.flip_h = false
			anim.play("Walk")
			flashlight.rotation_degrees = -94.7
		else:
			anim.play("Idle")
	if Input.is_action_pressed("ping") and !isPinging:
		isPinging = true
		ping()
		
	# Test feature for death / temporary touch
	
	
	
	if Input.is_key_pressed(KEY_L) and isDead:
		print("I am ALIVE!!")
		isDead = false
		sprite.modulate = Color("#ffffff")
		

func die():
	if isImmune:
		isImmune = false
		sprite.modulate = Color("#ffffff")
		print("Immunity gone!")
	else:
		sprite.modulate = Color("#ff1409")
		print("I am DEAD!!")
		isDead = true

func ping():
	timer.start(3)
	cdTimer.start(10)
	pingNode = ping.instance()
	
	get_parent().add_child(pingNode)
	
	pingNode.position = $Position2D.global_position
	timer.connect("timeout", self, "_on_Timer_timeout")
	cdTimer.connect("timeout", self, "_on_cdTimer_timeout")
	
func _on_Timer_timeout():
	if pingNode != null:
		pingNode.queue_free()
		timer.stop()

func _on_cdTimer_timeout():
	isPinging = false
	cdTimer.stop()
	
func puppet_position_set(new_value) -> void:
	puppet_position = new_value
	
	tween.interpolate_property(self, "global_position", global_position, puppet_position, 0.1)
	tween.start()

sync func update_position(pos):
	global_position = pos
	puppet_position = pos

func _on_Network_tick_rate_timeout():
	if is_network_master():
		rset_unreliable("puppet_position", global_position)
		rset_unreliable("puppet_velocity", velocity)

func username_set(new_value):
	username = new_value
	
	if is_network_master() and username_text_instance != null:
		username_text_instance.text = username

		rset("puppet_username", username)

func puppet_username_set(new_value):
	puppet_username = new_value
	
	if not is_network_master() and username_text_instance != null:
		
		username_text_instance.text = puppet_username

sync func destroy():
	username_text_instance.visible = false
	#visible = false
	#$CollisionShape2D.disabled = true
	#$Hitbox.CollisionShape2D.disabled = true		
	if is_network_master():
		Global.player_master = null

func _exit_tree():
	if is_network_master():
		Global.player_master = null

func _on_Power_timeout():

	speed = 200  


func _on_Light_timeout():
	canvasModulate.color = Color(0, 0, 0, 1)
	Global.flashlight = true

	
func collect_power(powerup):
	if powerup == "speed":
		timer.start(10)
		speed = 500
	if powerup == "life":
		isImmune = true
		sprite.modulate = Color("#2146ee")
		
	if powerup == "light":
		print("Let there be light")		

		var main_scene = get_tree().current_scene
		if main_scene:
			canvasModulate = main_scene.find_node("CanvasModulate", true, false)
			if canvasModulate:
				canvasModulate.color = Color(1, 1, 1, 1)
				Global.flashlight = false
			else:
				print("CanvasModulate not found.")
		else:
			print("No main scene found.")

		lightTimer.start(3)
		
	
	timer.connect("timeout", self, "_on_Power_timeout")
	lightTimer.connect("timeout", self, "_on_Light_timeout")
