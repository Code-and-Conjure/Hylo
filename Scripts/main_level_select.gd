class_name MainLevelSelect
extends Node2D

signal load_scene(scene_path: PackedScene)

@onready var load_sadness: LevelSelect = $LoadSadness
@onready var load_bargaining = $LoadBargaining
@onready var load_denial = $LoadDenial

# Called when the node enters the scene tree for the first time.
func _ready():
	load_sadness.go_to_level.connect(go_to_sadness)
	load_bargaining.go_to_level.connect(go_to_bargaining)
	load_denial.go_to_level.connect(go_to_denial)
	pass # Replace with function body.

func go_to_sadness() -> void:
	var sadness = load("res://Scenes/black_water_depression.tscn")
	load_scene.emit(sadness)
	
func go_to_bargaining() -> void:
	var bargaining = load("res://Scenes/air_level.tscn")
	load_scene.emit(bargaining)
	
func go_to_denial() -> void:
	var denial = load("res://Scenes/yellow_earth_denial.tscn")
	load_scene.emit(denial)
