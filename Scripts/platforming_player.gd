class_name PlatformingPlayer
extends CharacterBody2D

@export var SPEED = 400
@export var JUMP_VELOCITY = -600
var MAX_FALL_SPEED = 5000

var slowdown_factor: float = 1.0

@onready var hylo_back_sprite: Texture2D = load("res://Assets/hylo-back-FILLED_SKETCH.png")
@onready var hylo_front_sprite: Texture2D = load("res://Assets/hylo-FILLED_SKETCH.png")

@export var stats: TestResource
@export_range(0.0, 1.0) var swim_gravity_ratio: float = 0.3

@onready var killzone = $Killzone
@onready var platforming_player = $"."
@onready var hylo = $Hylo
@onready var weapon = $Weapon

var is_swimming: bool = false

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var fall_timer: Timer = $FallTimer

func _ready() -> void:
	$"Sad Mask".visible = GlobalDictionary.has_sad_mask
	
func add_sad_mask() -> void:
	$"Sad Mask".visible = true

func _physics_process(delta):
	if weapon.visible == false and GlobalDictionary.has_weapon: 
		weapon.visible = true
		
	if not is_on_floor():
		if is_swimming:
			velocity.y += gravity * delta * swim_gravity_ratio
		else:
			velocity.y += gravity * delta
		velocity.y = min(MAX_FALL_SPEED, velocity.y)
	else:
		killzone.monitoring = false
		
	if GlobalDictionary.has_weapon and Input.is_action_just_pressed("Parry"):
		weapon.parry()
	if Input.is_action_pressed("jump") and (is_on_floor() or is_swimming):
		killzone.monitoring = true
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("ui_down", false):
		set_collision_mask_value(2, false)
		fall_timer.start(.2)
		
	if (velocity.y < 0) and Input.is_action_just_released("jump"):
		velocity.y = -100

	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED * slowdown_factor
		if direction < 0:
			hylo.play("Walk Left")
		else:
			hylo.play("Walk Right")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Attack"):
		weapon.attack()
	
	if event.is_action_released("Attack"):
		weapon.stop_attack()

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


func _on_killzone_body_entered(_body):
	#body.queue_free()
	#decide if collectibles are enemies or coins/similar
	pass
