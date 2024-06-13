extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Lifepower_body_entered(body):
	if body.name in Global.player_id:
		body.collect_power("life")
		queue_free() 


func _on_Lifepower_area_entered(area):
		
	if "-power" in area.name:
		area.queue_free()
		yield(get_tree().create_timer(2), "timeout")
		OrbSpawner.relocate_power(area.name)