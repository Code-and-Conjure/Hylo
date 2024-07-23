class_name Airboss
extends CharacterBody2D

@export var Projectiles: Array[PackedScene]
@onready var shoot_timer = $ShootTimer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()

func _on_shoot_timer_timeout():
	
	scale.y = scale.y - .05
	scale.x = scale.x - .05
	if scale < Vector2(.01, .01) :
		queue_free()
		return
	
	var index = randi_range(0, len(Projectiles)-1)
	var bullet = Projectiles[index].instantiate()
	bullet.position = position
	owner.add_child(bullet)
