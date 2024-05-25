extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_red_orb_body_entered(body):
	if Global.number_of_players >= 6 and body.name == Global.player_id[2]:
		OrbCounter.incrementRedOrbs()
		self.queue_free()


func _on_red_orb_area_entered(area):
	if "_orb" in area.name:
		area.queue_free()
		#yield(get_tree().create_timer(1), "timeout")
		OrbSpawner.relocate_orb(area.name)

