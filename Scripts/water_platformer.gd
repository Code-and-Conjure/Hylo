class_name WaterLevel
extends Node2D

@onready var weapon_pickup = $"Weapon Pickup"
@onready var platforming_player = $PlatformingPlayer
@onready var water: Water = $PlatformerCamera/Water

@export var sink: float = 1

func _ready() -> void:
	weapon_pickup.body_entered.connect(add_weapon_to_player)

func add_weapon_to_player(player: Node2D) -> void:
	if player is PlatformingPlayer:
		GlobalDictionary.has_weapon = true
		weapon_pickup.queue_free()


func _on_sinking_timeout() -> void:
	water.position.y += sink

func _on_water_boss_die() -> void:
	$"Sad Mask".visible = true
	
