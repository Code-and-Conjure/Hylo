extends Control


func _on_continue_pressed() -> void:
	Events.continue_game.emit()


func _on_quit_pressed() -> void:
	Events.quit_game.emit()
