extends Control


func _ready():
	OS.open_midi_inputs()
	
	Points.rudiments_score = 0
	Points.groove_score = 0
	Points.fill_score = 0
	
func _input(event):
	if event is InputEventMIDI and event.pitch == 41:
			if event.velocity > 0:
			
				get_tree().change_scene_to_file("res://scenes/level/Level_1/Level_Abgabe_Rudiment.tscn")
				
	if event is InputEventMIDI and event.pitch == 42:
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
