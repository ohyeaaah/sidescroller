extends Sprite2D

var velocity: Vector2 = Vector2()

func _process(delta):
	position += velocity * delta
