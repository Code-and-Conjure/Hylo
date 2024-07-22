class_name HorizontalProjectile
extends CharacterBody2D

func _physics_process(delta):
	velocity.x = -500
	
	move_and_slide()

func _on_remove_timeout():
	queue_free()
