extends entity

func _physics_process(delta):
	direction = Input.get_axis("left", "right")
	move(delta, direction)
	if Input.is_action_just_pressed("jump"):
		jump()
	
