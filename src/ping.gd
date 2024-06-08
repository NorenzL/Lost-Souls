extends Sprite


puppet var puppet_position setget puppet_position_set

onready var initial_position = global_position

var player_owner = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	yield(get_tree(), "idle_frame")
	
	if is_network_master():
		rset("puppet_position", global_position)
	
	visible = true

func puppet_position_set(new_value) -> void:
	puppet_position = new_value
	
sync func destroy() -> void:
	queue_free()
	
func _on_Destroy_timer_timeout():
	if get_tree().is_network_server():
		rpc("destroy")
