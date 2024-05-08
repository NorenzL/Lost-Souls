extends Area2D

# Signal emitted when the orb is collected

# Flag to track if the orb has been collected
func _on_green_orb_body_entered(body):
	if body.name == "Player":
		OrbCounter.incrementGreenOrbs()
		self.queue_free()

