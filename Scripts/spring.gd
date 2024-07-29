extends Resource
class_name Spring

var force: float = 0.0
var velocity: float = 0.0
var position: Vector2 = Vector2.ZERO

func spring(_delta: float, k: float, dampening: float):
	var loss = -dampening * velocity
	
	force = -k * position.y + loss
	velocity += force
	position.y += velocity
