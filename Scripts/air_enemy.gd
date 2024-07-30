class_name AirEnemy
extends Area2D

var target: AirBoss

func _physics_process(delta):
	if not target:
		return
	var dir = position.direction_to(target.position)
	position += dir * 500 * delta

func recall(boss: AirBoss):
	target = boss

func _on_body_entered(body: Node2D):
	if not body is AirBoss:
		return
	body.absorbThing()
	Events.emit_signal("air_enemy_despawned")
	queue_free()
