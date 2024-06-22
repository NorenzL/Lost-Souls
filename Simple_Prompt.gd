extends Control


func _on_Ok_pressed():
	Global.player_id.resize(0)
	Global.number_of_players = 0
	get_tree().change_scene("res://src/Network_setup.tscn")

func set_text(text) -> void:
	$Label.text = text
