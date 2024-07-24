class_name AirBoss
extends StaticBody2D

@export_range (.1, 3.0) var ShootRadomness: float = 2
@export var Projectiles: Array[PackedScene]
@onready var shoot_timer = $ShootTimer
@onready var jump_timer = $JumpTimer

var JUMP_VELOCITY = -700
var airEnemycount: int = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player: PlatformingPlayer = get_tree().get_nodes_in_group("Player")[0]  

func _ready():
	Events.connect("air_enemy_despawned", decThing)
	set_scale(Vector2(.05, .05))

func recallThings():
	for thing: AirEnemy in get_tree().get_nodes_in_group("AirEnemy"):
		airEnemycount+=1
		thing.recall(self)
	print("I should recall them")

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
	bullet.set_target(player)
	owner.add_child(bullet)

func absorbThing():
	apply_scale(Vector2(1.1, 1.1))
	pass
	
func decThing():
	airEnemycount-=1
	if airEnemycount <= 0:
		shoot_timer.start()
