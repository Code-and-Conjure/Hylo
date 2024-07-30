class_name Player
extends CharacterBody2D

const SPEED = 20000.0
const JUMP_VELOCITY = -400.0
@onready var sprite = $Player

@export var stats: TestResource

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if stats:
		print(stats.health)

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	velocity = direction * SPEED * delta

	move_and_slide()
	
func save():
	return {
		"filename": get_scene_file_path(),
		"parent": get_parent().get_path(),
		"health": stats.health,
		"pos_x": position.x,
		"pos_y": position.y,
	}

func damage(amount: int):
	stats.health -= amount
	if stats.health <= 0:
		print("should die")
