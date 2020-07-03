tool
extends Button

export(String, FILE) var next_scene_path: = ""


func _on_button_up():
	$AudioStreamPlayer.play()
	get_tree().change_scene(next_scene_path)	
	#get_tree().change_scene("res://src/Levels/Tutorial.tscn")	
	
func _get_configuration_warning() -> String:
	return "next_scene_path must be set for button to work" if next_scene_path == "" else ""
