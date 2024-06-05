extends KinematicBody2D

onready var _agent: NavigationAgent2D = $NavigationAgent2D

onready var _timer: Timer = $Timer
onready var playerdetection = $playerdetection


var _velocity := Vector2.ZERO

var current_target = null
# Called when the node enters the scene tree for the first time.
func _ready():
	
	#_timer.connect("timeout", self, "_on_playedetection_body_entered")
	playerdetection.connect("body_entered", self, "_on_playerdetection_body_entered")
	
func _physics_process(delta: float) -> void:
	
	if _agent.is_navigation_finished():
		return 
	if current_target:
		_agent.set_target_location(current_target.global_position)
		var direction := global_position.direction_to(_agent.get_next_location())
		var desired_velocity := direction * 200
		var steering := (desired_velocity - _velocity) * delta * 4.0
		_velocity += steering
		_velocity = move_and_slide(_velocity)

func _update_pathfinding(location) -> void:
	_agent.set_target_location(current_target.global_position)

func _on_playerdetection_body_entered(body):
	if body is KinematicBody2D:
		
		current_target = body
		_update_pathfinding(body.global_position)


func _on_playerTouch_body_entered(body):
	if body is KinematicBody2D:
		body.die()
