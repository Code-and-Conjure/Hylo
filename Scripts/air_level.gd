class_name AirLevel
extends Node2D

@onready var area_2d = $Area2D
@onready var air_boss:AirBoss = $AirBoss

func _on_area_2d_body_entered(_dbody: Node2D):
	air_boss.recallThings()

func _on_air_boss_die() -> void:
	$BargainingMask.visible = true
	
