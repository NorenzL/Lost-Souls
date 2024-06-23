extends Label

var ip_address = ""

func _on_join_button_pressed():
	$click.play()
	Network.ip_address = ip_address
	Network.join_server()
	get_parent().get_parent().queue_free()
