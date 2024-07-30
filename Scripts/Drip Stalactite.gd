extends StaticBody2D

@onready var drip_timer = $"Drip Timer"

@onready var drip_scene: SlowDrip = preload("res://Scenes/slow_drip.tscn").instantiate()
@onready var drip_from = $"Drip From"

# Called when the node enters the scene tree for the first time.
func _ready():
	drip_timer.timeout.connect(spawn_drip)
	
	drip_scene.visible = false
	get_tree().root.add_child.call_deferred(drip_scene)
	
	drip_scene.should_destroy.connect(remove_from_scene)
	pass # Replace with function body.

func spawn_drip() -> void:
	drip_scene.visible = true
	drip_scene.start(drip_from.global_position)
	
func remove_from_scene(node: SlowDrip) -> void:
	drip_scene.visible = false
