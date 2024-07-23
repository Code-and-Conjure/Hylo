class_name HorizontalProjectile
extends CharacterBody2D

@onready var player: PlatformingPlayer = get_tree().get_nodes_in_group("Player")[0]
var vel = 0

func _ready():
	position.y = player.position.y
	var dir = position.direction_to(player.position)
	vel = 500 * dir.x

func _physics_process(delta):
	velocity.x = vel
	
	move_and_slide()

func _on_remove_timeout():
	queue_free()


func _on_area_2d_body_entered(body: PlatformingPlayer):
	print("damage player")
	queue_free()
