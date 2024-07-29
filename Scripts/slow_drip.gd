class_name SlowDrip
extends Area2D

func _ready() -> void:
	self.body_entered.connect(die_or_apply_status)
	
func _physics_process(delta: float) -> void:
	position.y += gravity * delta
	
func die_or_apply_status(node: Node2D) -> void:
	if node is PlatformingPlayer:
		node.slowdown()
	
	queue_free()

func start(spawn_point: Vector2) -> void:
	global_position = spawn_point
