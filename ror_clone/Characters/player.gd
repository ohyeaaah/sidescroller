extends entity

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _on_animated_sprite_2d_animation_finished():
	attacking_locked = false
	print("attack animation finished")

func _physics_process(delta):
	direction = Input.get_vector("left", "right", "up", "down")
	move(delta, direction)
	if Input.is_action_just_pressed("jump"):
		jump()
	if Input.is_action_pressed("click"):
		attack(animated_sprite)
	
	update_animation(animated_sprite)
	update_facing_direction(animated_sprite)
	

		

