extends KinematicBody2D

const ping = preload('res://src/ping.tscn')
export var speed: int = 200
export var jumpForce: int = 600
export var gravity: int = 800

var velocity: Vector2 = Vector2()
var grounded: bool = false
var isPinging: bool = false
var pingNode: KinematicBody2D = null

onready var sprite = $Sprite
onready var timer = $Timer
onready var cdTimer = $cdTimer
onready var flashlight = $flashlight

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.x = 0
	# Left and right movement
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.y += gravity * delta
	# jump
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y -= jumpForce
	# Flipping of player left and right
	if velocity.x < 0:
		sprite.flip_h = true
		flashlight.rotation_degrees = -266.4
	elif velocity.x > 0:
		sprite.flip_h = false
		flashlight.rotation_degrees = -94.7
		
	if Input.is_action_pressed("ping") and !isPinging:
		isPinging = true
		ping()

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

