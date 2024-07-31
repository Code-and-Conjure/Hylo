extends Node2D

#@onready var level_select = $LevelSelect
@onready var lose_screen: Control = $CanvasLayer/LoseScreen

@export var levelNode: Node

func _input(event):
	if event.is_action_pressed("save"):
		save_game()
	if event.is_action_pressed("load"):
		load_game()

func _ready():	
	#load_game()
	Events.load_scene.connect(load_resource)
	load_resource(load("res://Scenes/level_select.tscn"))
	
	Events.lose_condition.connect(lose)
	Events.continue_game.connect(continue_game)
	Events.quit_game.connect(quit_game)
	
func lose():
	var tmp1 = get_tree().root.get_children()
	var tmp2 = get_children()
	var tmp = levelNode.get_children()
	get_tree().paused = true
	lose_screen.show()
	
func continue_game():
	lose_screen.hide()
	get_tree().paused = false
	load_resource(load("res://Scenes/level_select.tscn"))
	
func quit_game():
	get_tree().quit()
	
func load_resource(level: PackedScene) -> void:
	#level_select.queue_free()
	var tmp = levelNode.get_children()
	for n in tmp:
		levelNode.remove_child.call_deferred(n)
		n.queue_free()
	levelNode.add_child.call_deferred(level.instantiate())

func save_game():
	var saveGame = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		saveGame.store_line(json_string)
	
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var game_data = FileAccess.open("user://savegame.save", FileAccess.READ)
	while game_data.get_position() < game_data.get_length():
		var json_string = game_data.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])

		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])
