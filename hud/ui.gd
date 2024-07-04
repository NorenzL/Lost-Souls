extends CanvasLayer

onready var altar_progress = get_node("Progress/ColorRect/AltarProgress/ProgressBar")
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.progressBar = self
	set_max_value(Global.number_of_players)
	altar_progress.value = 0
	

func set_max_value(max_value: int) -> void:
	altar_progress.max_value = max_value

func set_progress(score: int) -> void:
	altar_progress.value = score
