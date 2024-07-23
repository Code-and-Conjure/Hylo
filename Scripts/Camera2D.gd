class_name PlatformerCamera
extends Camera2D

@export var LockXAxis: bool = false
@export var LockYAxis: bool = false
@export_range (0,100) var PlayerSnap: float = 50
@export var AdjustSpeed: float = 50
@export var Player: PlatformingPlayer

func _physics_process(delta):
	var dist = position.distance_to(Player.position)
	var dir = position.direction_to(Player.position)
	if not LockXAxis and dist > PlayerSnap:
		position.x += dir.x * AdjustSpeed
		
	if not LockYAxis and dist > PlayerSnap:
		position.y += dir.y * AdjustSpeed
