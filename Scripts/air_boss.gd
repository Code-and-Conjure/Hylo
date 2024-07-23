class_name Airboss
extends CharacterBody2D

@export_range (.1, 3.0) var ShootRadomness: float = 2
@export var Projectiles: Array[PackedScene]
@onready var shoot_timer = $ShootTimer
@onready var jump_timer = $JumpTimer

var JUMP_VELOCITY = -700

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player: PlatformingPlayer = get_tree().get_nodes_in_group("Player")[0]  


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.x = 0
		
	move_and_slide()

func _on_shoot_timer_timeout():
	
	shoot_timer.wait_time = randf_range(.1, ShootRadomness)
	
	scale.y = scale.y - .05
	scale.x = scale.x - .05
	if scale < Vector2(.01, .01) :
		queue_free()
		return
	
	var index = randi_range(0, len(Projectiles)-1)
	var bullet = Projectiles[index].instantiate()
	bullet.position = position
	owner.add_child(bullet)


func _on_jump_timer_timeout():
	jump_timer.wait_time = randf_range(2, ShootRadomness+2)
	velocity.y = JUMP_VELOCITY
		
	var dir = position.direction_to(player.position)
	velocity.x = dir.x * 600
