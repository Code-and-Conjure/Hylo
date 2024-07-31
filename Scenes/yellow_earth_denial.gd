extends Node2D

@onready var message: RichTextLabel = %Message

func _ready():
	Events.display_text.connect(set_message_text)
	
func set_message_text(text: String) -> void:
	message.text = text


func _on_killzone_body_entered(body: Node2D) -> void:
	var player = body as PlatformingPlayer
	if not player:
		return
	Events.lose_condition.emit()
