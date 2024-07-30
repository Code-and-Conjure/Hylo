class_name SadMask
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is PlatformingPlayer:
		GlobalDictionary.has_sad_mask = true
		body.add_sad_mask()
		queue_free()

# TODO: !IMPORTANT! CHANGE SCENE TO HOME MENU!!!!!!!
