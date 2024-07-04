extends Node2D

onready var particle = $CPUParticles2D

# Called when the node enters the scene tree for the first time.
func play():
	particle.emitting = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
