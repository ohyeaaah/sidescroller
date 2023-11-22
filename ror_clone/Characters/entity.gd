extends CharacterBody2D
class_name entity

@export var speed : float = 200.0
@export var jump_velocity : float = -150.0
@export var double_jump_velocity : float = -100.0
@export var health: float = 100


#flag for animation switching
var animation_locked : bool = false
var attacking_locked : bool = false

#var vision = get_world_2d().direct_space_state
#var fov = get_viewport().size

var direction : Vector2 = Vector2.ZERO

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var in_air : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_animation(animated_sprite):
	if not animation_locked and attacking_locked == false:
		if direction.x != 0:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")

func update_facing_direction(animated_sprite):
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x <0:
		animated_sprite.flip_h = true
			
func attack(animated_sprite):
	if attacking_locked == false:
		attacking_locked = true
		animated_sprite.play("attack")
	
func move(delta,dir):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jumped = false
	if dir:
		velocity.x = dir.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0 , speed)
		
	move_and_slide()

#handles jumping 	
#need to give enemies ability to jump without input 
func jump(animated_sprite):
		animated_sprite.play("jump_start1")
		animation_locked = true
		in_air = true
		if is_on_floor():
			velocity.y = jump_velocity
		elif not has_double_jumped:
			velocity.y = double_jump_velocity
			has_double_jumped = true
#handles moving
func land(animated_sprite):
	animated_sprite.play("jump_end1")
	in_air = false
	
func entity_check(pos):
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta):
	pass
