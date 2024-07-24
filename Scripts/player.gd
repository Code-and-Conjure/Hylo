extends CharacterBody2D


const SPEED = 20000.0
const JUMP_VELOCITY = -400.0

@export var stats: TestResource

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if stats:
		print(stats.health)

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	var verticalDirection = Input.get_axis("ui_up", "ui_down")
	
	if direction:
		velocity.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED);
		
	if verticalDirection:
		velocity.y = verticalDirection
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED);
	
	velocity = velocity.normalized() * SPEED * delta
		

	move_and_slide()
	
func save():
	return {
		"filename": get_scene_file_path(),
		"parent": get_parent().get_path(),
		"health": stats.health,
		"pos_x": position.x,
		"pos_y": position.y,
	}
