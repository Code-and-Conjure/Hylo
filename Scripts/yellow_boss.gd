extends StaticBody2D

@export var target: Node2D
@export_range (10, 250) var speed: float = 170

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var face_right = false
var runningAway = false
var tmpTimer: float = 3

func _physics_process(delta: float) -> void:
	tmpTimer -= delta
	if tmpTimer <= 0:
		face_right = randi_range(0, 1)
		tmpTimer = 3
			
	if face_right:
		sprite_2d.flip_h = false
		set_collision_layer_value(5, false)
		set_collision_layer_value(4, true)
	else:
		sprite_2d.flip_h = true
		set_collision_layer_value(5, true)
		set_collision_layer_value(4, false)
	if runningAway:
		scale *= 1-delta
		var dir = position.direction_to(target.position)
		position += dir * speed * delta
		
		if position.distance_to(target.position) < 5:
			var fire_level = load("res://Scenes/fire_level.tscn")
			Events.load_scene.emit(fire_level)
			queue_free()

func damage(_amount: int) -> void:
	runningAway = true
	face_right = false
