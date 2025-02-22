class_name WaterBoss
extends RigidBody2D

signal die

@onready var attack_timer = $Attack
@onready var origin: Marker2D = $Origin

@export var projectile_speed: float = 75

@export var health: int = 10000

func _physics_process(_delta: float):
	if health <= 0:
		die.emit()
		queue_free()

func _ready() -> void:
	attack_timer.timeout.connect(fire_projectiles)
	for projectile_position in get_tree().get_nodes_in_group("ProjectilePoint"):
		var mark = projectile_position as Marker2D
		if not mark:
			continue
	
		var projectile = projectile_position.get_children()[0] as SlowDrip
		projectile.should_destroy.connect(reset_projectile)
	
func fire_projectiles() -> void:
	for projectile_position: Marker2D in get_tree().get_nodes_in_group("ProjectilePoint"):
		var direction = (projectile_position.position - origin.position).normalized()
		var projectile = projectile_position.get_children()[0] as SlowDrip
		projectile.visible = true
		projectile.start(projectile_position.global_position, direction * projectile_speed)
		
func reset_projectile(projectile: SlowDrip) -> void:
	projectile.visible = false
	pass
