extends CharacterBody2D

# Player variables
var speed = 400
var JUMP_VELOCITY = -900
var is_sneaking = false
var is_jumping = false

# Input handling
func _process(delta):
	handle_input()
	update_sprite_animation()

func handle_input():
	is_sneaking = Input.is_action_pressed("sneak_right") or Input.is_action_pressed("sneak_left")

	if Input.is_action_pressed("jump"):
		is_jumping = true
	else:
		is_jumping = false

	velocity = Vector2()
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1

	if is_sneaking:
		velocity *= 0.5  # Reduce speed when sneaking

	velocity = velocity.normalized() * speed

func update_sprite_animation():
	if is_sneaking:
		if velocity.x > 0:
			$AnimatedSprite2D.animation("sneak_right")
		elif velocity.x < 0:
			$AnimatedSprite2D.animation("sneak_left")
	else:
		if velocity.x > 0:
			$AnimatedSprite2D.animation("walk_right")
		elif velocity.x < 0:
			$AnimatedSprite2D.animation("walk_left")
#        else:
 #           $AnimatedSprite2D.animation("idle")

# Getters for sneaking and jumping states
func is_player_sneaking() -> bool:
	return is_sneaking

func is_player_jumping() -> bool:
	return is_jumping
