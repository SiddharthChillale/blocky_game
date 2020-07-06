extends Control

onready var label: Label = $Score


func _ready()-> void :
	label.text = label.text % [PlayerData.score, PlayerData.deaths]


func _on_Feedback_pressed():
	OS.shell_open("https://forms.gle/jthpmeuNichoqkiK8")
