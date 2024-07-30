class_name FireBullet
extends RigidBody2D


@export var damage: int = 10
var target: Vector2
var force: float = 300
var seek: Node2D
var hasLifetime: bool = false
var lifetime: float

func _physics_process(delta):
	if hasLifetime:
		lifetime -= delta
		if lifetime <= 0:
			queue_free()
	if target:
		if seek:
			var dir = position.direction_to(target)
			position += dir * force * delta
			if position.distance_to(target) <= 5:
				target = seek.position
		else:
			var dir = position.direction_to(target)
			position += dir * force * delta
		
		if position.distance_to(target) <= 5:
			queue_free()
		

func set_target(t: Vector2):
	target = t

func set_force(f: float):
	force = f

func set_seek(s: Node2D):
	seek = s
	
func set_lifetime(l: float):
	hasLifetime = true
	lifetime = l

func launch():
	pass


func _on_area_2d_body_entered(body: Player):
	body.damage(damage)
	queue_free()
