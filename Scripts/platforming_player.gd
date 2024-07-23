class_name PlatformingPlayer
extends CharacterBody2D

var SPEED = 130
var JUMP_VELOCITY = -400

@onready var killzone = $Killzone

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var fall_timer: Timer = $FallTimer

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		killzone.monitoring = false
		
	if Input.is_action_pressed("jump") and is_on_floor():
		killzone.monitoring = true
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_pressed("ui_down", false):
			set_collision_mask_value(2, false)
			fall_timer.start(.2)
		
	move_and_slide()


func _on_fall_timer_timeout():
	set_collision_mask_value(2, true)


func _on_killzone_body_entered(body):
	body.queue_free()
