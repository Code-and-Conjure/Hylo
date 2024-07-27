extends Node2D

@onready var water = $Water
@onready var drown_timer = $DrownTimer
@onready var warning_text_timer = $"Warning Text Timer"
@onready var warning_text = $"CanvasLayer/Warning Text"

# Called when the node enters the scene tree for the first time.
func _ready():
	water.body_entered.connect(start_drown_timer)
	water.body_exited.connect(stop_drown_timer)
	
	warning_text.visible = false
	
	drown_timer.timeout.connect(transition_to_platformer)
	warning_text_timer.timeout.connect(show_warning_text)
	pass # Replace with function body.

func start_drown_timer(_body: Node2D) -> void:
	drown_timer.start(10)
	warning_text_timer.start(2)
	
func stop_drown_timer(_body: Node2D) -> void:
	drown_timer.stop()
	warning_text_timer.stop()
	warning_text.visible = false
	
func show_warning_text() -> void:
	warning_text.visible = true

func transition_to_platformer() -> void:
	get_tree().change_scene_to_file("res://Scenes/water_platformer.tscn")
