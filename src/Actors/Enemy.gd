# extends "res://src/Actors/Actor.gd"

extends Actor
onready var anim_player :AnimationPlayer = get_node("AnimationPlayer")
onready var enemy_sprite := $enemy

export var enemy_score: = 100
export var delay_mseconds: = 100

func _ready():
	_velocity.x = -speed.x

func _on_StompDetector_body_entered(body):
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	# OS.delay_msec(delay_mseconds)
	die()


func _physics_process(delta):
	_velocity.y += gravity*delta
	
	if is_on_wall():
		_velocity *= -1.0
		
		enemy_sprite.set_flip_h(not enemy_sprite.is_flipped_h())
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func die():
	
	
	anim_player.play("dead")
	print("playing dead animation")
	var t = Timer.new()
	t.set_wait_time(0.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	t.queue_free()
	queue_free()
	PlayerData.score += enemy_score

