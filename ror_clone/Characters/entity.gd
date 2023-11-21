extends CharacterBody2D
class_name entity

@export var speed : float = 200.0
@export var jump_velocity : float = -150.0
@export var double_jump_velocity : float = -100.0
@export var health: float = 100

#var vision = get_world_2d().direct_space_state
#var fov = get_viewport().size

var direction

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move(delta,dir):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jumped = false
	if dir:
		velocity.x = dir * speed
	else:
		velocity.x = move_toward(velocity.x, 0 , speed)
		
	move_and_slide()

#handles jumping 	
#need to give enemies ability to jump without input 
func jump(delta):
		if is_on_floor():
			velocity.y = jump_velocity
		elif not has_double_jumped:
			velocity.y = double_jump_velocity
			has_double_jumped = true
#handles moving

func entity_check(pos):
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta):
	pass
