extends Node2D

var area_texts = {
	"EarthText1": "text here1",
	"EarthText2": "text here2",
	"EarthText3": "text here3",
	"EarthText4": "text here4",
	"EarthText5": "text here5",
	"EarthText6": "text here6",
	"EarthText7": "text here7"
}

func _ready():
	for area_name in area_texts.keys():
		var area = get_node(area_name)
		area.connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
		area.connect("body_exited", Callable(self, "_on_Area2D_body_exited"))

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):  # Ensure only the player triggers the text
		var area_name = body.get_parent().name
		InnerMonologue.display_text(area_texts[area_name])

func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):  # Ensure only the player triggers the text
		InnerMonologue.hide_text()
	
func _process(delta):
	pass


func _on_earth_text_1_body_entered(body):
	pass # Replace with function body.


func _on_earth_text_2_body_entered(body):
	pass # Replace with function body.


func _on_earth_text_3_body_entered(body):
	pass # Replace with function body.


func _on_earth_text_4_body_entered(body):
	pass # Replace with function body.


func _on_earth_text_5_body_entered(body):
	pass # Replace with function body.


func _on_earth_text_6_body_entered(body):
	pass # Replace with function body.


func _on_earth_text_7_body_entered(body):
	pass # Replace with function body.


func _on_earth_text_1_body_exited(body):
	pass # Replace with function body.


func _on_earth_text_2_body_exited(body):
	pass # Replace with function body.


func _on_earth_text_3_body_exited(body):
	pass # Replace with function body.


func _on_earth_text_4_body_exited(body):
	pass # Replace with function body.


func _on_earth_text_5_body_exited(body):
	pass # Replace with function body.


func _on_earth_text_6_body_exited(body):
	pass # Replace with function body.


func _on_earth_text_7_body_exited(body):
	pass # Replace with function body.
