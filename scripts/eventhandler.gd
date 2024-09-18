extends Control


# Declare member variables
var escape_count = 0
var target_scene_path = "res://scenes/screens/main_menu.tscn"

# Function to load the target scene
func load_scene():
	
	get_tree().change_scene_to_file(str(target_scene_path))


# Function to handle input events
func _input(event):
	if event.is_action_pressed("ui_cancel"):  # Default action for the Escape key
		escape_count += 1
		if escape_count >= 3:
			load_scene()
			escape_count = 0
	#elif event.is_action_pressed("ui_any_other_key"):  # Reset count if any other key is pressed
	#	escape_count = 0
