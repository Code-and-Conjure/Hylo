extends Node2D

@onready var water = $Water
@onready var drown_timer = $DrownTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	water.body_entered.connect(start_drown_timer)
	water.body_exited.connect(stop_drown_timer)
	
	drown_timer.timeout.connect(transition_to_platformer)
	pass # Replace with function body.

func start_drown_timer(body: Node2D) -> void:
	drown_timer.start(10)
	pass
	
func stop_drown_timer(body: Node2D) -> void:
	drown_timer.stop()
	pass

func transition_to_platformer() -> void:
	print("go to next level")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
