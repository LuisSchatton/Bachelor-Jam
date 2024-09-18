extends Node3D

var note_count: int

@export var level = "rudiment"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Conductor.repeat_count = 3
	
	


func _on_conductor_lesson_ended():
	print(note_count)
	Points.rudiments_score = Scoring.scoreTotal
	Scoring.scoreTotal = 0
	Global.current_scene = "res://scenes/level/Level_1/Level_Abgabe_Rudiment.tscn"
	Global.next_scene = "res://scenes/level/Level_1/Level_Abgabe_Groove.tscn"
	get_tree().change_scene_to_file("res://scenes/screens/score_screen.tscn")
	
	
