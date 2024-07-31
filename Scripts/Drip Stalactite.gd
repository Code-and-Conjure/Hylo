extends StaticBody2D

@onready var drip_timer = $"Drip Timer"

@onready var drip_scene: SlowDrip = preload("res://Scenes/slow_drip.tscn").instantiate()
@onready var drip_from = $"Drip From"

@export var delay: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	if delay > 0:
		$Offset.start(delay)
	else:
		_on_offset_timeout()
		
	drip_timer.timeout.connect(spawn_drip)
	
	drip_scene.visible = false
	get_tree().root.add_child.call_deferred(drip_scene)
	
	drip_scene.should_destroy.connect(remove_from_scene)
	pass # Replace with function body.

func spawn_drip() -> void:
	drip_scene.visible = true
	drip_scene.gravity_scale = 0.05
	drip_scene.start(drip_from.global_position)
	
func remove_from_scene(_node: SlowDrip) -> void:
	drip_scene.visible = false


func _on_offset_timeout() -> void:
	drip_timer.start()
