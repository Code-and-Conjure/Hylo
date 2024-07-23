class_name PlayerSeekingProjectile
extends CharacterBody2D

@onready var player: PlatformingPlayer = get_tree().get_nodes_in_group("Player")[0]  
var target: Vector2


func _ready():
	target = player.position

func _physics_process(delta):
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
	print("damage player")
	queue_free()
