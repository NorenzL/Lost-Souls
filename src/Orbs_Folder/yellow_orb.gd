extends Area2D


func _on_yellow_orb_body_entered(body):
	if body.name == "Player":
		OrbCounter.incrementYellowOrbs()
		self.queue_free()
