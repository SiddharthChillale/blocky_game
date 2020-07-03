extends Button



func _on_button_up():
	$AudioStreamPlayer.play()
	get_tree().quit()
