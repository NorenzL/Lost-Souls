extends KinematicBody2D

onready var _agent: NavigationAgent2D = $NavigationAgent2D

onready var _timer: Timer = $Timer
onready var playerdetection = $playerdetection

onready var player_touch = $playerTouch
onready var stun_timer = $stunTimer
onready var sprite = $Enemy
var _velocity := Vector2.ZERO
var target_queue := []
var isStunned: bool = false setget set_stun
var isRaging: bool = false
onready var altar_reference = get_node("../../Altar")

var preset_locations = [
	Vector2(1216, -1952),
	Vector2(1536, -1960),
	Vector2(1536, -1760),
	Vector2(1536, -1584),
	Vector2(1536, -1384),
	Vector2(1536, -1208),
	Vector2(-376, -1592),
	Vector2(1888, -616),
	Vector2(536, -128),
	Vector2(-1480, -744),
	Vector2(-1760, 2632),
	Vector2(-500, 1848),
	Vector2(0, -2416),
	Vector2(1344, 2432),
	Vector2(2640, 1176)
]

var current_preset_index = 0

puppet var puppet_isStunned: bool = false setget puppet_set_stun

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#_timer.connect("timeout", self, "_on_playedetection_body_entered")
	playerdetection.connect("body_entered", self, "_on_playerdetection_body_entered")
	player_touch.connect("area_entered", self, "_on_playerTouch_area_entered")
	player_touch.connect("area_exited", self, "_on_playerTouch_area_exited")
	stun_timer.connect("timeout", self, "_on_stunTimer_timeout")

	altar_reference.connect("door_state_changed", self, "_on_door_state_changed")
func _physics_process(delta: float) -> void:
	
	if isStunned and !(isRaging):
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
			
			if direction.x != 0:
				sprite.flip_h = direction.x < 0 
		else:
			target_queue.pop_front() # Remove the target if it is no longer valid
			
		
func _on_door_state_changed(is_open: bool) -> void:
	if is_open:
		isRaging = true
		print("Door is open, enemy is now raging.")
		
func _update_pathfinding() -> void:
	if target_queue.size() > 0:
		var current_target = target_queue[0]
		_agent.set_target_location(current_target.global_position)

func set_stun(new_value):
	isStunned = new_value
	
	if is_network_master():
		rset("puppet_isStunned", isStunned)
		
func puppet_set_stun(new_value):
	puppet_isStunned = new_value
	
	if not is_network_master():
		isStunned = puppet_isStunned
	
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
		$Curse.play()
		body.die()
		
		if body in target_queue:
			target_queue.erase(body)
			target_queue.append(body)  # Move to the end of the queue
			if target_queue.size() > 0:
				_update_pathfinding()

func _on_playerTouch_area_entered(area):
	var player = area.get_parent() as KinematicBody2D
	
	if area.name == "stunner" and !(player.isDead):
		isStunned = true 
		$Curse.play()
		stun_timer.start(5)
		

func _on_playerTouch_area_exited(area):
	if area.name == "stunner":
		isStunned = false
		stun_timer.stop()
		


func _on_stunTimer_timeout():
	current_preset_index = (current_preset_index + 1) % preset_locations.size()
	global_position = preset_locations[current_preset_index]
	
	
	if target_queue.size() > 0:
		var first_target = target_queue.pop_front()
		target_queue.append(first_target)
		
		
	isStunned = false
	stun_timer.stop()
	_update_pathfinding()


func _on_ParanoiaAOE_body_entered(body):
	if Global.player_id.has(body.name):
		body.isParanoid = true


func _on_ParanoiaAOE_body_exited(body):
	if Global.player_id.has(body.name):
		body.isParanoid = false
