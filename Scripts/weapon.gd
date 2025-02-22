class_name Weapon
extends Node2D

signal parry_hit(node: Node2D)
signal attack_hit(node: Node2D)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var danger_zone: Area2D = $DangerZone
@onready var hit_cooldown: Timer = $"Hit Cooldown"
@onready var slowdown_effect: Timer = $"Slowdown Effect"

var bodies: Array[Node2D] = []

func _ready() -> void:
	slowdown_effect.timeout.connect(reset_engine_time)
	
func reset_engine_time() -> void:
	Engine.time_scale = 1.0

func parry() -> void:
	animation_player.play("Parry")
	if not animation_player.animation_finished.is_connected(stop_parry):
		animation_player.animation_finished.connect(stop_parry)
	if danger_zone.body_entered.is_connected(parry_node):
		return
	danger_zone.set_collision_mask_value(5, false)
	danger_zone.set_collision_mask_value(7, false)
	danger_zone.set_collision_mask_value(3, true)
	danger_zone.body_entered.connect(parry_node)
	
func stop_parry(_animation_name: String) -> void:
	if danger_zone.body_entered.is_connected(parry_node):
		danger_zone.body_entered.disconnect(parry_node)
		
	if animation_player.animation_finished.is_connected(stop_parry):
		animation_player.animation_finished.disconnect(stop_parry)
	
func parry_node(node: Node2D) -> void:
	danger_zone.body_entered.disconnect(parry_node)
	parry_hit.emit(node)
	Engine.time_scale = 0.7
	slowdown_effect.start()
	if node is HorizontalProjectile or node is PlayerSeekingProjectile:
		node.reflect()
	
func attack() -> void:
	animation_player.play("Begin Attack")
	danger_zone.set_collision_mask_value(5, true)
	danger_zone.set_collision_mask_value(7, true)
	danger_zone.set_collision_mask_value(3, false)
	if animation_player.animation_finished.is_connected(damage_bodies):
		return
	animation_player.animation_finished.connect(damage_bodies)
	
func damage_bodies(_animation_name: String) -> void:
	animation_player.animation_finished.disconnect(damage_bodies)
	
	if not danger_zone.body_entered.is_connected(attack_node):
		danger_zone.body_entered.connect(attack_node)
	if not danger_zone.body_exited.is_connected(remove_attack_node):
		danger_zone.body_exited.connect(remove_attack_node)
	if not hit_cooldown.timeout.is_connected(hit_nodes):
		hit_cooldown.timeout.connect(hit_nodes)
	
	hit_cooldown.start()
	animation_player.play("Attacking")
	
func remove_attack_node(node: Node2D) -> void:
	bodies.erase(node)
	if bodies.size() == 0:
		$"Weapon Sprite/Suck Enemies".emitting = false
	
func stop_attack() -> void:
	animation_player.play("Idle")
	if danger_zone.body_entered.is_connected(attack_node):
		danger_zone.body_entered.disconnect(attack_node)
	if danger_zone.body_exited.is_connected(remove_attack_node):
		danger_zone.body_exited.disconnect(remove_attack_node)
	if hit_cooldown.timeout.is_connected(hit_nodes):
		hit_cooldown.timeout.disconnect(hit_nodes)
		
	if animation_player.animation_finished.is_connected(damage_bodies):
		animation_player.animation_finished.disconnect(damage_bodies)
	bodies.clear()
	$"Weapon Sprite/Suck Enemies".emitting = false
	hit_cooldown.stop()
	
func attack_node(node: Node2D) -> void:
	bodies.push_front(node)
	$"Weapon Sprite/Suck Enemies".emitting = true
	hit_nodes()
	
func hit_nodes() -> void:
	for body in bodies:
		if body is WaterBoss:
			body.health -= 100
			continue
		if body.has_method("damage"):
			body.damage(100000)
