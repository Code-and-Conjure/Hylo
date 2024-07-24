class_name Water
extends Polygon2D

@export var points: int = 300
@export var dist: float = 20
@export var depth: int = 1000
@export_range(0.0, 1.0) var springyness: float = 0.99
@export_range(0.0, 1.0) var dampening: float = 0.9
@export_range(0.0, 1.0) var spread: float = 0.2

var springs: Array[Vector3] = [Vector3.ZERO]
var isStillWater: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in points:
		springs.push_front(Vector3((1+i) * dist * -1, 0.0, 0.0))
		springs.push_back(Vector3((1+i) * dist, 0.0, 0.0))
	
	ripple(0.0, 50)
	
func ripple(pos_x: float, impact: float) -> void:
	for i in springs.size():
		var distance = abs(springs[i].x - pos_x)
		if distance == 0.0:
			springs[i].y -= impact
			continue
			
		var sqDist = pow(spread, distance)
		springs[i].y -= impact * sqDist
	pass
	
func _physics_process(delta: float) -> void:
	for i in springs.size():
		# apply springy force
		springs[i].z += -springs[i].y * delta
		springs[i].z *= dampening * springyness
		springs[i].y += springs[i].z
		
	queue_redraw()
	pass

func get_water_shape() -> PackedVector2Array:
	var array: PackedVector2Array = []
	for i in springs:
		array.append(Vector2(i.x, i.y))
	array.append(Vector2(springs[springs.size() - 1].x, depth))
	array.append(Vector2(springs[0].x, depth))
	return array

func _draw():
	draw_polygon(get_water_shape(), [Color("1111ff")])

