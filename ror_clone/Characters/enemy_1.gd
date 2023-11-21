extends entity
var rng = RandomNumberGenerator.new()

#var player_loc = get_parent().get_node("player").get_pos()
#var self_pos = get_parent().get_node("enemy").get_pos()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta, direction)
#	if self_pos.x - player_loc.x < 0:      
#		direction = -1
#	else:
#		direction = 1
#	move(delta, direction)
#	await get_tree().create_timer(2).timeout
