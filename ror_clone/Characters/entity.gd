extends CharacterBody2D
class_name entity

@export var speed : float = 200.0
@export var jump_velocity : float = 150.0
@export var double_jump_velocity : float = -100.0
@export var health: float = 100
@export var dash_velocity : float = -150

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
	if not animation_locked and not attacking_locked:
		if direction.x != 0:
			animated_sprite.play("run")
			in_air = false
		else:
			animated_sprite.play("idle")
			in_air = false

func update_facing_direction(animated_sprite):
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x <0:
		animated_sprite.flip_h = true

func attack_melee(animated_sprite):
	if attacking_locked == false:
		attacking_locked = true
		animated_sprite.play("attack")

const bulletpath = preload ("res://bullet.tscn")
var bullet = bulletpath.instantiate()

func attack_ranged(animated_sprite):
	if attacking_locked == false:
		animated_sprite.play("attack")
		get_parent().add_child(bullet)
		bullet.position = $Marker2D.global_position
		bullet.velocity = Vector2(bullet.speed, 0)
		attacking_locked = true
		animation_locked = true
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
	animation_locked = true

func player_skill_1(animated_sprite):
	animated_sprite.play("dash1")
	animation_locked = true
	velocity.y = dash_velocity
	velocity.x = dash_velocity
	
	in_air = true

func entity_check(pos):
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta):
	pass
