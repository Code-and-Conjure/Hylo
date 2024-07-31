extends Node2D

@onready var anger_mask: AngryMask = $AngerMask

func _on_fire_boss_die(pos: Vector2) -> void:
	anger_mask.position = pos
	anger_mask.show()
