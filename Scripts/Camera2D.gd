class_name PlatformerCamera
extends Camera2D

@export var LockXAxis: bool = false
@export var LockYAxis: bool = false
@export_range (0,100) var PlayerSnap: float = 50
@export_range (0,500) var LookaheadFactor: float = .07
@export var AdjustSpeed: float = 5
@export var Player: PlatformingPlayer

@export var BeginBound: Marker2D
@export var EndBound: Marker2D

@export_range (0,50) var MAX_DISTANCE: float = 1

func _physics_process(delta):
	var out = Player.velocity * delta * LookaheadFactor
	var dist = position.distance_to(Player.position + out)
	var dir = position.direction_to(Player.position)
	
	dist = min(dist, MAX_DISTANCE)
	
	if LockXAxis:
		dir.x = 0
		
	if LockYAxis:
		dir.y = 0
	
	position += lerp(Vector2.ZERO, dist * dir, dist/MAX_DISTANCE)
	
	if BeginBound:
		position.y = max(BeginBound.position.y, position.y)
		position.x = max(BeginBound.position.x, position.x)
		
	if EndBound:
		position.y = min(EndBound.position.y, position.y)
		position.x = min(EndBound.position.x, position.x)
		
