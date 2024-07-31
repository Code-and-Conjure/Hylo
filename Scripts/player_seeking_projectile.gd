class_name PlayerSeekingProjectile
extends CharacterBody2D

@export var reflect_speed: int = 1000

@export var spawn_source: PhysicsBody2D
@export var damage: int = 10
@onready var target: PhysicsBody2D 
var target_position: Vector2
@onready var area_2d = $Area2D

func _physics_process(_delta: float) -> void:
	if not target:
		return
		
	if position == target_position:
		target_position = target.position
	
	var dir = position.direction_to(target_position)
	if target is PlatformingPlayer:
		velocity = dir * (target.SPEED + 5)
	else:
		velocity = dir * reflect_speed
	move_and_slide()


func _on_target_timer_timeout() -> void:
	if target != null:
		target_position = target.position
	else:
		queue_free()

func _on_remove_timeout() -> void:
	queue_free()

func _on_area_2d_body_entered(body: PhysicsBody2D):
	body.damage(damage)
	queue_free()
	
func set_target(new_target: PhysicsBody2D):
	target = new_target
	target_position = target.position

func reflect() -> void:
	area_2d.set_collision_mask_value(5, true)
	area_2d.set_collision_mask_value(1, false)
	if spawn_source != null:
		set_target(spawn_source)
	else:
		queue_free()
