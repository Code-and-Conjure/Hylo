class_name AirLevel
extends Node2D

@onready var area_2d = $Area2D
@onready var air_boss = $AirBoss

func _ready():
	#air_boss.paused
	pass


func _on_area_2d_body_entered(body: PlatformingPlayer):
	air_boss.process_mode = Node.PROCESS_MODE_INHERIT
	area_2d.queue_free()
