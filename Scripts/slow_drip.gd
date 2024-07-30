class_name SlowDrip
extends Area2D

var velocity: Vector2 = Vector2.ZERO

signal should_destroy(drip: SlowDrip)

func _ready() -> void:
	self.body_entered.connect(die_or_apply_status)
	
func _physics_process(delta: float) -> void:
	velocity += gravity * delta * gravity_direction
	position += velocity
	
func die_or_apply_status(node: Node2D) -> void:
	if node is PlatformingPlayer:
		node.slowdown(0.9)
	should_destroy.emit(self)

func start(spawn_point: Vector2, initial_velocity: Vector2 = Vector2.ZERO) -> void:
	global_position = spawn_point
	velocity = initial_velocity
