class_name Water
extends Area2D

@onready var collision_polygon_2d = $CollisionPolygon2D

@export var points: int = 300
@export var dist: float = 10
@export var depth: int = 5000
@export_color_no_alpha var texture: Color

@export_range(0.0, 1.0) var impact: float = 0.1

@export_range(0.0,1.0) var k = 0.016
@export_range(0.0,1.0) var dampening = 0.04
@export_range(0.0,1.0) var spread = 0.12

var bodies: Array[Node2D] = []

var springs: Array[Spring] = [Spring.new()]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	springs[0].position.y = 100
	for i in points:
		var front = Spring.new()
		front.position.x = (1+i) * dist * -1
		springs.push_front(front)
		
		var back = Spring.new()
		back.position.x = (1+i) * dist
		springs.push_back(back)
		
	collision_polygon_2d.polygon = build_collision_polygon()
	
	self.body_entered.connect(ripple_enter)
	self.body_exited.connect(ripple_exit)
	
func ripple_enter(body: Node2D) -> void:
	bodies.append(body)
		
	var player = body as PlatformingPlayer
	if player:
		player.start_swimming()
		
	if body is PhysicsBody2D:
		ripple(body)
	
func ripple_exit(body: PhysicsBody2D) -> void:
	bodies.erase(body)
	var player = body as PlatformingPlayer
	if player:
		player.stop_swimming()
	ripple(body)
	
func ripple(body: PhysicsBody2D):
	for spring in springs:
		if abs(spring.position.x - to_local(body.position).x) < dist and body is CharacterBody2D:
			spring.position.y += body.velocity.y * impact

func build_collision_polygon() -> PackedVector2Array:
	var array: PackedVector2Array = []
	array.append(Vector2(points * dist, 0.0))
	array.append(Vector2(points * dist * -1, 0.0))
	array.append(Vector2(points * dist * -1, depth))
	array.append(Vector2(points * dist, depth))
	return array

func _physics_process(delta) -> void:
	for spring in springs:
		spring.spring(delta, k, dampening)
	
	var index: int = 0
	var prev: Spring
		
	for curr in springs:
		if prev:
			prev.velocity += spread * (curr.position.y - prev.position.y)
		if index < springs.size() - 1:
			springs[index + 1].velocity += spread * (curr.position.y - springs[index + 1].position.y)
		prev = curr
		index += 1
	queue_redraw()

func get_water_shape() -> PackedVector2Array:
	var array: PackedVector2Array = []
	for i in springs:
		array.append(Vector2(i.position.x, i.position.y))
	array.append(Vector2(springs[springs.size() - 1].position.x, depth))
	array.append(Vector2(springs[0].position.x, depth))
	return array

func _draw():
	draw_polygon(get_water_shape(), [texture])

