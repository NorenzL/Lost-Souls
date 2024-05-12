extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_blue_orb_body_entered(body):
	# Check if the orb has not been collected yet
	if body.name == "Player" or body.name == "1"or body.name == "2"or body.name == "4"or body.name == "4":
		OrbCounter.incrementBlueOrbs()
		self.queue_free()
