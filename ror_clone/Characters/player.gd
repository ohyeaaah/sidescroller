extends entity

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D


func _on_animated_sprite_2d_animation_finished():
	if (animated_sprite.animation == "jump_start1"):
		if is_on_floor:
			land(animated_sprite)
	if (animated_sprite.animation == "attack"):
		attacking_locked = false
		animation_locked = false
		print("attack animation finished")
	if (animated_sprite.animation == "dash1"):
		animation_locked = false
	
func _physics_process(delta):
	direction = Input.get_vector("left", "right", "up", "down")
	move(delta, direction)
	if Input.is_action_just_pressed("jump"):
		jump(animated_sprite)
	if Input.is_action_pressed("click"):
		attack_ranged(animated_sprite)
	if Input.is_action_pressed("skill_movement"):
		player_skill_1(animated_sprite)
	if is_on_floor() and not in_air:
		animation_locked = false
	update_animation(animated_sprite)
	update_facing_direction(animated_sprite)
	

		

