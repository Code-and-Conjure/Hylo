class_name PlatformingPlayer
extends CharacterBody2D

@export var SPEED = 400
@export var JUMP_VELOCITY = -900
var MAX_FALL_SPEED = 5000
@export_range (.1, 1) var AttackSlowdownFactor = .5

var slowdown_factor: float = 1.0

@onready var hylo_back_sprite: Texture2D = load("res://Assets/hylo-back-FILLED_SKETCH.png")
@onready var hylo_front_sprite: Texture2D = load("res://Assets/hylo-FILLED_SKETCH.png")

@export var stats: TestResource
@export_range(0.0, 1.0) var swim_gravity_ratio: float = 0.3

@onready var platforming_player = $"."
@onready var hylo = $Hylo
@onready var weapon_pivot: Marker2D = $"Weapon Pivot"
@onready var weapon: Weapon = $"Weapon Pivot/Weapon"


var is_swimming: bool = false
var is_attacking: bool = false

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var fall_timer: Timer = $FallTimer

func _ready() -> void:
	$"Sad Mask".visible = GlobalDictionary.has_sad_mask
	weapon.visible = GlobalDictionary.has_weapon
	$"Bargaining Mask".visible = GlobalDictionary.has_bargaining_mask
	
func add_sad_mask() -> void:
	$"Sad Mask".visible = true
	
func add_weapon() -> void:
	weapon.visible = true

func add_bargaining_mask() -> void:
	$"Bargaining Mask".visible = true
	
func _physics_process(delta):
	weapon_pivot.look_at(get_global_mouse_position())
		
	if not is_on_floor():
		if is_swimming:
			velocity.y += gravity * delta * swim_gravity_ratio
		else:
			velocity.y += gravity * delta
		velocity.y = min(MAX_FALL_SPEED, velocity.y)
		
	if Input.is_action_pressed("jump") and (is_on_floor() or is_swimming):
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("ui_down", false):
		set_collision_mask_value(2, false)
		fall_timer.start(.2)
		
	if (velocity.y < 0) and Input.is_action_just_released("jump"):
		velocity.y = -100

	var direction = Input.get_axis("ui_left", "ui_right")
	var localSpeed = SPEED
	
	if is_attacking:
		localSpeed *= AttackSlowdownFactor
	
	if direction:
		velocity.x = direction * localSpeed * slowdown_factor
		if direction < 0:
			hylo.play("Walk Left")
		else:
			hylo.play("Walk Right")
	else:
		velocity.x = move_toward(velocity.x, 0, localSpeed)
		
		
	move_and_slide()

func _input(event: InputEvent) -> void:
	if GlobalDictionary.has_weapon and event.is_action_pressed("Attack"):
		weapon.attack()
		is_attacking = true
	
	if GlobalDictionary.has_weapon and event.is_action_released("Attack"):
		weapon.stop_attack()
		is_attacking = false
		
	if GlobalDictionary.has_weapon and event.is_action_released("Parry"):
		weapon.parry()

func damage(amount: int):
	stats.health -= amount
	if stats.health <= 0:
		print("should die")
		
func start_swimming():
	is_swimming = true

func stop_swimming():
	is_swimming = false
	
func slowdown(by: float):
	slowdown_factor *= by

func _on_fall_timer_timeout():
	set_collision_mask_value(2, true)
