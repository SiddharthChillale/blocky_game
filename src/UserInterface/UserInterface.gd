extends Control

onready var scene_tree: = get_tree() 
onready var pause_overlay: = $PauseOverlay
onready var score: Label = $Label
onready var pause_title: Label = $PauseOverlay/Title 

var paused:= false setget set_paused

func _ready() -> void:
	PlayerData.connect("music_updated", self, "_on_MusicCheck_toggled")
	$PauseOverlay/MusicCheck.pressed = PlayerData.music_state
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_PlayerData_player_died")
	
	update_interface()


func _PlayerData_player_died() -> void :
	self.paused = true
	pause_title.text = "YOU DIED"
	
	$PauseOverlay/VBoxContainer/Resume.queue_free()
	$PauseOverlay/VBoxContainer/Control.queue_free()
	

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		handle_pause()

func update_interface() -> void:
	score.text = "Score: %s" % PlayerData.score

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func handle_pause():
	self.paused = not paused
	scene_tree.set_input_as_handled()

func _on_Feedback_pressed():
	OS.shell_open("https://forms.gle/jthpmeuNichoqkiK8")

func _on_Resume_pressed():
	handle_pause()


func _on_MusicCheck_toggled(button_pressed):
	PlayerData.music_state = not button_pressed
