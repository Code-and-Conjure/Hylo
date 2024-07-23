class_name HorizontalProjectile
extends CharacterBody2D

@export var BulletSpeed: float = 800
@export var damage: int = 10
var vel: Vector2
var player: PlatformingPlayer

func _physics_process(delta):
	velocity = vel
	
	move_and_slide()

func _on_remove_timeout():
	queue_free()

func _on_area_2d_body_entered(body: PlatformingPlayer):
	body.damage(damage)
	queue_free()

func set_target(target: PlatformingPlayer):
	player = target
	var dir = position.direction_to(player.position)
	vel = BulletSpeed * dir
	
	var rot = position.angle_to(player.position)
	rotate(rot)
