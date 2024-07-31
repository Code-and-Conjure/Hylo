class_name LevelSelect
extends Area2D

signal go_to_level

var player_entered_area: bool = false

func _ready() -> void:
	self.body_entered.connect(watch_body)
	self.body_exited.connect(stop_watch_body)
	
func stop_watch_body(node: Node2D) -> void:
	if node is Player:
		player_entered_area = false

func watch_body(node: Node2D) -> void:
	if node is Player:
		player_entered_area = true

func _input(event: InputEvent):
	if player_entered_area and event.is_action_pressed("level_select"):
		go_to_level.emit()
