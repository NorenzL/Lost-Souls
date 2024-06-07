extends KinematicBody2D

onready var _agent: NavigationAgent2D = $NavigationAgent2D

onready var _timer: Timer = $Timer
onready var playerdetection = $playerdetection

onready var player_touch = $playerTouch

var _velocity := Vector2.ZERO
var target_queue := []
var isStunned: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#_timer.connect("timeout", self, "_on_playedetection_body_entered")
	playerdetection.connect("body_entered", self, "_on_playerdetection_body_entered")
	player_touch.connect("area_entered", self, "_on_playerTouch_area_entered")
	player_touch.connect("area_exited", self, "_on_playerTouch_area_exited")

	
func _physics_process(delta: float) -> void:
	if isStunned:
		return
		
	if _agent.is_navigation_finished():
		return 
	if target_queue.size() > 0:
		var current_target = target_queue[0]
		if current_target:
			_agent.set_target_location(current_target.global_position)
			var direction := global_position.direction_to(_agent.get_next_location())
			var desired_velocity := direction * 200
			var steering := (desired_velocity - _velocity) * delta * 4.0
			_velocity += steering
			_velocity = move_and_slide(_velocity)
		else:
			target_queue.pop_front() # Remove the target if it is no longer valid

func _update_pathfinding() -> void:
	if target_queue.size() > 0:
		var current_target = target_queue[0]
		_agent.set_target_location(current_target.global_position)

func _on_playerdetection_body_entered(body):
	if body is KinematicBody2D && !(body in target_queue) && !(body.isDead):
		
		print(body.name, " is detected")
		print("location is: ", body.global_position)
		target_queue.append(body)
		print("the targets are: ", target_queue)
		if target_queue.size() > 0:
			_update_pathfinding()


func _on_playerTouch_body_entered(body):
	if body is KinematicBody2D:
		body.die()
		if body in target_queue:
			target_queue.erase(body)
			target_queue.append(body)  # Move to the end of the queue
			if target_queue.size() > 0:
				_update_pathfinding()

func _on_playerTouch_area_entered(area):
	if area.name == "stunner":
		isStunned = true 
		


func _on_playerTouch_area_exited(area):
	if area.name == "stunner":
		isStunned = false
		
