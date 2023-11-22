extends entity
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not direction:
		direction.x = rng.randf_range(-1, 1)
	else: 
		direction.x = 0
	move(delta, direction)
