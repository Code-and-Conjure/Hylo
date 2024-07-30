class_name WaterLevel
extends Node2D

@onready var weapon_pickup = $"Weapon Pickup"
@onready var platforming_player = $PlatformingPlayer

func _ready() -> void:
	weapon_pickup.body_entered.connect(add_weapon_to_player)


func add_weapon_to_player(player: Node2D) -> void:
	if player is PlatformingPlayer:
		player.has_weapon = true
		weapon_pickup.queue_free()
