extends Node2D
#(19,4) (-28, 4)  if (enemy.position.x - (spawn_area.x/2) > 0) 
#get position of player
@onready var player_pos = get_parent().get_node("entity/Player").position 
#size of viewport should be (288, 162) for spawning area
@onready var spawn_area = get_viewport_rect().size

#since the player is always in the center of the viewport, the visible area around the player extends by 144 x and 81 y

#get number of enemies in scene
#hook up to signal when enemy spawns to get new list of active enemiess
@onready var enemy_list = get_parent().get_node("entity").get_children()

#preload enemy type for spawning
const enemy_type = preload("res://Characters/enemy_1.tscn")
var prox_enemies : int = 0

#this value will be changed by the difficulty scaling
var enemy_limit : int = 5

var rng = RandomNumberGenerator.new()
#function to change the direction of the enemy based on where they are in relation to the player
func change_dir():
	for enemy in enemy_list:
		if enemy.position.x > player_pos.x:
			enemy.direction.x = - 1
		else:
			enemy.direction.x = 1

func difficulty_manager():
	pass
#maybe only call this when an enemy dies, or based on difficulty
func spawn_manager():
	#pick random spawn locations inside viewport to spawn enemies
	#need to change to exlude area around a player
	#need to set health and strength of the enemies spawned based on difficulty
	var spawn_loc_x_left : int = rng.randi_range(player_pos.x - (spawn_area.x*2), player_pos.x - (spawn_area.x))
	var spawn_loc_x_right : int = rng.randi_range(player_pos.x + (spawn_area.x*2), player_pos.x - (spawn_area.x))
	var spawn_loc_arr : Array = []
	
	spawn_loc_arr.append(spawn_loc_x_left)
	spawn_loc_arr.append(spawn_loc_x_right)
	
	for enemy in enemy_list:
		if (enemy.position.x > (player_pos.x - (spawn_area.x*2))) and (enemy.position.x < (player_pos.x + (spawn_area.x*2))):
			prox_enemies += 1 
	
			
	if prox_enemies <= enemy_limit:
		var enemy = enemy_type.instantiate()
		get_parent().get_node("entity").add_child(enemy)
		
		enemy.position.x = spawn_loc_arr[randi() % spawn_loc_arr.size()]
		#will have to change vertical spawning later to account for flying enemies
		enemy.position.y = player_pos.y
		
		enemy_list.append(enemy)
		print("enemy spawned")
	
	prox_enemies = 0
		
# Called when the node enters the scene tree for the first time.
func _ready():
	#first entity in list will always be the player --> get rid of it 
	enemy_list.erase(enemy_list[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_pos = get_parent().get_node("entity/Player").position 
	change_dir()
	spawn_manager()
	#print(player_pos)
