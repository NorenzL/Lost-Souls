extends Area2D



func _on_red_orb_body_entered(body):
	if body.name == "Player":
		OrbCounter.incrementRedOrbs()
		self.queue_free()
