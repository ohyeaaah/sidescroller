extends Sprite2D
var speed: float = 900
var velocity: Vector2 = Vector2()

func _process(delta):
	position += velocity * delta
