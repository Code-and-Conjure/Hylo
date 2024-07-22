class_name PlayerSeekingProjectile
extends RigidBody2D

@onready var player: PlatformingPlayer = get_tree().get_nodes_in_group("Player")[0]  

func _physics_process(delta):
	position.x = move_toward(position.x, player.position.x, player.SPEED*.95*delta)
	position.y = move_toward(position.y, player.position.y, player.SPEED*.95*delta)
