class_name MainLevelSelect
extends Node2D

@onready var load_sadness: LevelSelect = $LoadSadness
@onready var load_bargaining = $LoadBargaining
@onready var load_denial = $LoadDenial
@onready var win_panel: Sprite2D = $WinPanel

func _ready():
	load_sadness.go_to_level.connect(go_to_sadness)
	load_bargaining.go_to_level.connect(go_to_bargaining)
	
	if GlobalDictionary.has_weapon:
		load_denial.visible = true
		load_denial.go_to_level.connect(go_to_denial)
	if GlobalDictionary.has_angry_mask and GlobalDictionary.has_sad_mask and GlobalDictionary.has_bargaining_mask:
		win_panel.show()

func go_to_sadness() -> void:
	var sadness = load("res://Scenes/black_water_depression.tscn")
	Events.load_scene.emit(sadness)
	
func go_to_bargaining() -> void:
	var bargaining = load("res://Scenes/air_level.tscn")
	Events.load_scene.emit(bargaining)
	
func go_to_denial() -> void:
	var denial = load("res://Scenes/yellow_earth_denial.tscn")
	Events.load_scene.emit(denial)
