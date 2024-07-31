class_name MirrorShard
extends Node2D

var state = "lit"
var player_in_area = false

func _ready() -> void:
	pass
		
#func _process(delta):
#	if state == "lit":
#		$AnimatedSprite2D.play("not lit")
#	if state == "not lit":
#		$AnimatedSprite2D.play("not lit")
	

func _on_collect_body_entered(body) -> void:
	if body.has_method("player"):
		player_in_area = true

func _on_collect_body_exited(body) -> void:
	if body.has_method("player"):
		player_in_area = false
