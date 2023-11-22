extends entity
class_name Player

var animation_locked : bool = false
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
func update_animation(): 
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("run1")
			animation_locked = false
		else:
			animated_sprite.play("idle1")
			animation_locked = false

func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true


const bulletPath = preload("res://bullet.tscn")
var bullet_speed : float = 300 
func shoot():
	animated_sprite.play("shoot1")
	animation_locked = true
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Marker2D.global_position
	bullet.velocity = Vector2(bullet_speed, 0)
	
func _on_animated_sprite_2d_animation_finished():
	if(animated_sprite.animation == "shoot1"):
		animation_locked = false
	if(animated_sprite.animation == "jump1"):
		animation_locked = false
	
func _physics_process(delta):
	direction.x = Input.get_axis("left", "right")
	move(delta, direction)
	if Input.is_action_just_pressed("jump"):
		jump(delta)
		animated_sprite.play("jump1")
		animation_locked = true
	if Input.is_action_pressed("Attack"):
		shoot()
	
	update_animation()
	update_facing_direction()
