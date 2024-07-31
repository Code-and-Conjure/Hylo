class_name AngryMask
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GlobalDictionary.has_angry_mask = true
		Events.load_scene.emit(load("res://Scenes/level_select.tscn"))
		queue_free()
