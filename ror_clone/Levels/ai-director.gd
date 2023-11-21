extends Node2D

#get position of player
@onready var player_pos = get_parent().get_node("entity/Player").position 

#get number of enemies in scene
#hook up to signal when enemy spawns to get new list of active enemiess
@onready var enemy_list = get_parent().get_node("entity").get_children()
# Called when the node enters the scene tree for the first time.
func _ready():
	#first entity in list will always be the player --> get rid of it 
	enemy_list.erase(enemy_list[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_pos = get_parent().get_node("entity/Player").position 
	for enemy in enemy_list:
		if enemy.position.x > player_pos.x:
			enemy.direction = - 1
		else:
			enemy.direction = 1
	#print(player_pos)
