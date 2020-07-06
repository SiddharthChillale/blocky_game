extends Actor

onready var CameraNode: = $Camera2D
onready var Player: = $"."
onready var anim_player :AnimationPlayer = get_node("AnimationPlayer")
onready var player_sprite: = $PlayerSprite

onready var player_health: = get_tree().get_nodes_in_group("Health")



export var stomp_impulse := 1000.0

var _health: = 3
var _jumpWasPressed = false


func _on_EnemyDetector_area_entered(area):
	# animation stomp and dust
	
	_velocity = calc_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body):
	
	if not player_health.empty():
		anim_player.play("hurt")
		var heart = player_health.pop_back()
		heart.queue_free()
		_health -= 1
	
	if _health == 0:
		die()
	
	


func _physics_process(delta):
	
	var direction = get_direction()
	var is_jump_interrupted := Input.is_action_just_released("jump") and _velocity.y < 0.0
	_velocity = cal_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
	
	
	var player_position :Vector2 =Player.get_position()
	var camera_bottom_limit = CameraNode.limit_bottom
	if player_position.y > camera_bottom_limit:
		print("Died from Falling")
		die()
	

func get_direction():
	
	var face_direction: = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if _is_just_jumped() else 1.0
	)
	
	if _is_just_jumped():
		$Player_jump.play()
	
	if Input.is_action_just_pressed("move_right") and Player.has_node("PlayerSprite"):
		# right face and trails animation
		player_sprite.set_flip_h(false)
		$Player_walk.play()
		pass
	elif Input.is_action_just_pressed("move_left") and Player.has_node("PlayerSprite"):
		# left face and trails animation
		$Player_walk.play()
		player_sprite.set_flip_h(true)
		pass
	
	return face_direction

func _is_just_jumped():
	var out: = Input.is_action_just_pressed("jump") and is_on_floor()

	return out

func cal_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
):
	var new_velocity := linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
		
	if is_jump_interrupted:
		new_velocity.y = 0
	return new_velocity

func calc_stomp_velocity(
	linear_velocity: Vector2,
	impulse: float
)-> Vector2:
	var out := linear_velocity
	out.y = -impulse
	return out

func die():
	anim_player.play("dies")
	var t = Timer.new()
	t.set_wait_time(0.8)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	t.queue_free()
	queue_free()
	PlayerData.deaths += 1
	
	
