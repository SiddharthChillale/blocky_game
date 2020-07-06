extends Node

signal score_updated
signal player_died
signal music_updated

var score: = 0 setget set_score
var deaths: = 0 setget set_deaths
var music_state = true setget set_music_state

func reset()-> void:
	score = 0
	deaths = 0


func set_score(value: int)-> void: 
	score = value
	emit_signal("score_updated")

func set_music_state(value: bool)-> void:
	AudioServer.set_bus_mute(1, value)
	emit_signal("music_updated")

func set_deaths(value: int)-> void: 
	deaths = value
	emit_signal("player_died")
