extends Camera2D

export var look_down_dist : = 0.50



func _physics_process(delta):
	if Input.is_action_pressed("look_down"):
		offset_v = look_down_dist
	else:		
		offset_v = 0


