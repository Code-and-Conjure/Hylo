class_name EarthEnemy
extends AnimatableBody2D

@export var speed: float = 200
var target: PhysicsBody2D

var velocity: Vector2 = Vector2.ZERO
var is_right: bool = true

func _physics_process(delta: float) -> void:
	if target is PlatformingPlayer: # If you can sneak while in the zone `and target.sneaking_slowdown == 1.0`
		velocity.x = speed * delta * sign(target.position.x - position.x)
	elif is_right:
		velocity.x = speed * delta
	else :
		velocity.x = -speed * delta
		
	var collision = move_and_collide(velocity)
	if collision:
		is_right = not is_right

func _on_detection_body_entered(body: Node2D) -> void:
	if body is PlatformingPlayer and body.sneaking_slowdown == 1.0:
		target = body

func _on_detection_body_exited(body: Node2D) -> void:
	if body is PlatformingPlayer:
		target = null

func _on_attack_body_entered(body: Node2D) -> void:
	if body is PlatformingPlayer and body.sneaking_slowdown == 1.0:
		body.damage(15)
