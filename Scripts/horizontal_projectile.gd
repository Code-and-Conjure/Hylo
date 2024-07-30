class_name HorizontalProjectile
extends CharacterBody2D

@export var spawn_source: PhysicsBody2D
@export var reflectSpeed: float = 1200
@export var bulletSpeed: float = 800
@export var damage: int = 10
var vel: Vector2
var target: PhysicsBody2D
@onready var area_2d = $Area2D
@onready var collision_shape_2d = $CollisionShape2D


func _physics_process(_delta: float) -> void:
	velocity = vel
	
	move_and_slide()

func _on_remove_timeout() -> void:
	queue_free()

func _on_area_2d_body_entered(body: PhysicsBody2D) -> void:
	body.damage(damage)
	queue_free()

func set_target(new_target: PhysicsBody2D) -> void:
	target = new_target
	var dir = position.direction_to(target.position)
	if target is PlatformingPlayer:
		vel = bulletSpeed * dir
	else:
		vel = dir * reflectSpeed
	
	var rot = position.angle_to(target.position)
	rotate(rot)

func reflect() -> void:
	area_2d.set_collision_mask_value(5, true)
	area_2d.set_collision_mask_value(1, false)
	set_target(spawn_source)
