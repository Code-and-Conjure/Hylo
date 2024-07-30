extends RigidBody2D

@export var Health: int = 100
@export_range (.1, 1) var AttackRandomness: float = .5
@export var TopLeftBound: Marker2D
@export var BottomRightBound: Marker2D
@export var player: Player
@export var fireBullet: PackedScene
@export_range (.1, 100) var BulletSpread: float = 75
@export_range (10, 1000) var SpawnOffset: float = 250

@onready var attack_timer = $AttackTimer

enum Attack {HORIZONTAL, SPIRAL, FOLLOW}

var state: Attack

func _ready():
	attack_timer.start(randf_range(0, AttackRandomness))

func _physics_process(delta):
	pass

func horizontalAttack():
	print("should do horizontal")
	var dir = randi()%4
	var playerSize: Vector2 = player.sprite.texture.get_size() * player.sprite.get_scale()
	
	match dir:
		0: #TOP
			print("Shoot from the top")
			var startPos = TopLeftBound.position
			var endPos = BottomRightBound.position
			for xpos in range(startPos.x, endPos.x, playerSize.x+BulletSpread):
				var bullet: FireBullet = fireBullet.instantiate()
				bullet.position = Vector2(xpos, startPos.y)
				bullet.linear_velocity = Vector2(0, 100)
				bullet.set_target(Vector2(xpos, endPos.y))
				owner.add_child(bullet)
				bullet.launch()
		1: #RIGHT
			print("Shoot from the right")
			var startPos = Vector2(BottomRightBound.position.x, TopLeftBound.position.y)
			var endPos = Vector2(BottomRightBound.position.x, BottomRightBound.position.y)
			for ypos in range(startPos.y, endPos.y, playerSize.y+BulletSpread):
				var bullet: FireBullet = fireBullet.instantiate()
				bullet.position = Vector2(startPos.x, ypos)
				bullet.set_target(Vector2(endPos.x, ypos))
				owner.add_child(bullet)
				bullet.launch()
		2: #DOWN
			print("Shoot from the down")
			var endPos = TopLeftBound.position
			var startPos = BottomRightBound.position
			for xpos in range(startPos.x, endPos.x, (playerSize.x+BulletSpread)*-1):
				var bullet: FireBullet = fireBullet.instantiate()
				bullet.position = Vector2(xpos, startPos.y)
				bullet.set_target(Vector2(xpos, endPos.y))
				owner.add_child(bullet)
				bullet.launch()
		3: #LEFT
			print("Shoot from the left")
			var startPos = Vector2(TopLeftBound.position.x, TopLeftBound.position.y)
			var endPos = Vector2(BottomRightBound.position.x, BottomRightBound.position.y)
			for ypos in range(startPos.y, endPos.y, playerSize.y+BulletSpread):
				var bullet: FireBullet = fireBullet.instantiate()
				bullet.position = Vector2(startPos.x, ypos)
				bullet.set_target(Vector2(endPos.x, ypos))
				owner.add_child(bullet)
				bullet.launch()
				
	attack_timer.start(.2 + randf_range(0, AttackRandomness))
	
	
func spiralAttack():
	print("should do spiral")
	var amount = (2.0*PI)/25.0
	var playerPos = player.position
	var dir = randi()%2
	var rng: Array
	
	match dir:
		0:
			rng = range(0.0, 25)
		1:
			rng = range(25, 0, -1)
	
	for i in rng:
		var r = i * amount
		var bullet: FireBullet = fireBullet.instantiate()
		bullet.position = Vector2((SpawnOffset * cos(r) + playerPos.x), (SpawnOffset * sin(r) + playerPos.y))
		bullet.set_target(playerPos)
		bullet.set_force(100)
		owner.add_child(bullet)
		bullet.launch()
		await get_tree().create_timer(.1).timeout

	for i in rng:
		var r = i * amount
		var bullet: FireBullet = fireBullet.instantiate()
		bullet.position = Vector2((SpawnOffset * cos(r) + playerPos.x), (SpawnOffset * sin(r) + playerPos.y))
		bullet.set_target(playerPos)
		bullet.set_force(100)
		owner.add_child(bullet)
		bullet.launch()
		await get_tree().create_timer(.1).timeout
		
	attack_timer.start(.1 + randf_range(0, AttackRandomness))
	
func followAttack():
	for i in range(0, randi_range(10, 15)):
		var xDir = [-1, 1].pick_random()
		var yDir = [-1, 1].pick_random()
		
		var xPos = randf_range(SpawnOffset, SpawnOffset*2)
		var yPos = randf_range(SpawnOffset, SpawnOffset*2)
		
		var bullet: FireBullet = fireBullet.instantiate()
		bullet.position = Vector2(player.position.x + (xPos*xDir), player.position.y + (yPos *yDir))
		bullet.set_target(player.position)
		bullet.set_force(150)
		bullet.set_seek(player)
		bullet.set_lifetime(15.0)
		owner.add_child(bullet)
		bullet.launch()
		await get_tree().create_timer(.1).timeout
	attack_timer.start(.1 + randf_range(0, AttackRandomness))

func _on_attack_timer_timeout():
	Health -= 1
	state = Attack.values().pick_random()
	match state:
		Attack.SPIRAL:
			spiralAttack()
		Attack.HORIZONTAL:
			horizontalAttack()
		Attack.FOLLOW:
			followAttack()
