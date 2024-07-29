extends Node2D

var state = "lit"
var player_in_area = false

func _ready():
	if state == "lit":
		$
		
#func _process(delta):
#	if state == "lit":
#		$AnimatedSprite2D.play("not lit")
#	if state == "not lit":
#		$AnimatedSprite2D.play("not lit")
	

func _on_collect_body_entered(body):
	if body.has_method("player"):
		player_in_area = true

func _on_collect_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
