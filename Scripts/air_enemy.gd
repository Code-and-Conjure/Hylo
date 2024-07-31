class_name AirEnemy
extends StaticBody2D

var target: AirBoss

func _physics_process(delta):
	if not target:
		return
	var dir = position.direction_to(target.position)
	
	if position.distance_to(target.position) <= 5:
		position += dir * 1
	else:
		position += dir * 500 * delta
		

func recall(boss: AirBoss):
	target = boss
	
func damage(_amount: int):
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body is AirBoss:
		return
	body.absorbThing()
	Events.emit_signal("air_enemy_despawned")
	queue_free()
