class_name WaterLevel
extends Node2D

@onready var weapon_pickup = $"Weapon Pickup"
@onready var platforming_player = $PlatformingPlayer
@onready var water: Water = $PlatformerCamera/Water
@onready var message: RichTextLabel = $CanvasLayer/Message

@export var sink: float = 1

func _ready() -> void:
	weapon_pickup.body_entered.connect(add_weapon_to_player)
	Events.display_text.connect(set_message_text)

func add_weapon_to_player(player: Node2D) -> void:
	if player is PlatformingPlayer:
		GlobalDictionary.has_weapon = true
		weapon_pickup.queue_free()
		player.add_weapon()

func _on_sinking_timeout() -> void:
	water.position.y += sink
	
	if water.position.y >= 500:
		Events.lose_condition.emit()
		sink = 0
		print("Lost the game - restart the water level")

func _on_water_boss_die() -> void:
	$"Sad Mask".visible = true
	
func set_message_text(text: String) -> void:
	message.text = text
