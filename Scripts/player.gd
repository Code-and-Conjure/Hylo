class_name Player
extends CharacterBody2D

const SPEED = 20000.0
const JUMP_VELOCITY = -400.0
@onready var sprite = $Player

@export var stats: TestResource
@onready var weapon: Weapon = $"Weapon Pivot/Weapon"
@onready var weapon_pivot: Marker2D = $"Weapon Pivot"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$SadMask.visible = GlobalDictionary.has_sad_mask
	weapon.visible = GlobalDictionary.has_weapon
	if stats:
		print(stats.health)

func _physics_process(delta):
	weapon_pivot.look_at(get_global_mouse_position())
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down", 0)
	
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false
		
	if GlobalDictionary.has_weapon and Input.is_action_just_pressed("Parry"):
		weapon.parry()
	
	velocity = direction * SPEED * delta

	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if GlobalDictionary.has_weapon and event.is_action_pressed("Attack"):
		weapon.attack()
	
	if GlobalDictionary.has_weapon and event.is_action_released("Attack"):
		weapon.stop_attack()
		
	if GlobalDictionary.has_weapon and event.is_action_released("Parry"):
		weapon.parry()
	
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
