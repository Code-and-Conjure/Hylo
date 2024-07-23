class_name PlayerSeekingProjectile
extends CharacterBody2D

@export var damage: int = 10
@onready var player: PlatformingPlayer 
var target: Vector2


func _physics_process(delta):
	if not player:
		return
		
	if position == target:
		target = player.position
	
	var dir = position.direction_to(target)
	var distance = position.distance_to(target)
	velocity = dir * (player.SPEED + 5)
	move_and_slide()


func _on_target_timer_timeout():
	target = player.position

func _on_remove_timeout():
	queue_free()

func _on_area_2d_body_entered(body: PlatformingPlayer):
	body.damage(damage)
	queue_free()
	
func set_target(playerTarget: PlatformingPlayer):
	player = playerTarget
	target = player.position
