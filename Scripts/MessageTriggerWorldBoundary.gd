class_name MessageTrigger
extends Area2D

@export var text: String

func _ready() -> void:
	self.body_entered.connect(emit_text)
	
func emit_text(body: Node2D) -> void:
	if body is PlatformingPlayer or body is Player:
		Events.display_text.emit(text)
