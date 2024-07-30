extends CanvasLayer

@onready var label = $Label

func _ready():
	print("Ready function called.")
	print("InnerMonologue Path: ", get_path())
	
	if label:
		print("Label node found.")
	else:
		print("Label node not found.")
		print_tree()
	
	if label:
		label.visible = false

func display_text(text: String):
	if label:
		label.text = text
		label.visible = true
	else:
		print("Label node not found in display_text.")

func hide_text():
	if label:
		label.visible = false
	else:
		print("Label node not found in hide_text.")
