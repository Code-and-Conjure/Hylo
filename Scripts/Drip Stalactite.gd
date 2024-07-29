extends StaticBody2D

@onready var drip_timer = $"Drip Timer"

var drip_scene = preload("res://Scenes/slow_drip.tscn")
@onready var drip_from = $"Drip From"

# Called when the node enters the scene tree for the first time.
func _ready():
	drip_timer.timeout.connect(spawn_drip)
	pass # Replace with function body.

func spawn_drip() -> void:
	var drip: SlowDrip = drip_scene.instantiate()
	get_tree().root.add_child(drip)
	drip.start(drip_from.global_position)
