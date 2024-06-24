extends CanvasLayer


func _ready() -> void:
	Global.ui = self

func _exit_tree() -> void:
	Global.ui = null

func _on_Disconnect_Server_pressed():
	$click.play()
	get_tree().change_scene("res://src/Network_setup.tscn")
