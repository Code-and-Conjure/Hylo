extends Node2D


@onready var message: RichTextLabel = $CanvasLayer/Message

func _ready():
	Events.display_text.connect(set_message_text)
	
func set_message_text(text: String) -> void:
	message.text = text

