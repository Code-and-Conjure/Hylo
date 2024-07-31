class_name AirLevel
extends Node2D

@onready var area_2d = $Area2D
@onready var air_boss:AirBoss = $AirBoss

func _ready():
	#air_boss.paused
	pass


func _on_area_2d_body_entered(_dbody: Node2D):
	air_boss.recallThings()
	area_2d.queue_free()
