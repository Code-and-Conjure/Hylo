extends Node2D

@onready var water = $Water
@onready var drown_timer = $DrownTimer
@onready var warning_text_timer = $"Warning Text Timer"
@onready var warning_text: RichTextLabel = %"Warning Text"

@export var messages: Array[String] = [""]

var i = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	water.body_entered.connect(start_drown_timer)
	water.body_exited.connect(stop_drown_timer)
	
	warning_text.visible = false
	
	drown_timer.timeout.connect(transition_to_platformer)
	warning_text_timer.timeout.connect(show_warning_text)

func start_drown_timer(_body: Node2D) -> void:
	drown_timer.start(10)
	warning_text_timer.start(2)
	
func stop_drown_timer(_body: Node2D) -> void:
	drown_timer.stop()
	warning_text_timer.stop()
	warning_text.visible = false
	
func show_warning_text() -> void:
	warning_text.text = messages[i % messages.size()]
	i += 1
	warning_text.visible = true

func transition_to_platformer() -> void:
	var sadness_boss = load("res://Scenes/water_platformer.tscn")
	Events.load_scene.emit(sadness_boss)
