extends KinematicBody2D

export var speed: int = 200
export var jumpForce: int = 600
export var gravity: int = 800

var velocity: Vector2 = Vector2(0,0)
var grounded: bool = false

var direction = 1;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.y += gravity * delta

	if is_on_wall():
		direction = direction * -1
