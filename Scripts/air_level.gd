class_name AirLevel
extends Node2D

@onready var area_2d = $Area2D
@onready var air_boss:AirBoss = $AirBoss
@onready var message: RichTextLabel = %Message

func _ready():
	Events.display_text.connect(set_message_text)

func _on_area_2d_body_entered(_dbody: Node2D):
	air_boss.recallThings()

func _on_air_boss_die() -> void:
	$BargainingMask.visible = true


func set_message_text(text: String) -> void:
	message.text = text
