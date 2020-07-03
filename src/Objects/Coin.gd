extends Area2D

onready var anim_player :AnimationPlayer = get_node("AnimationPlayer")

export var coin_score:= 10

func _on_body_entered(body):
	# $AudioStreamPlayer.stop()
	# $AudioStreamPlayer.play()
	PlayerData.score += coin_score
	anim_player.play("Fade_out")	
