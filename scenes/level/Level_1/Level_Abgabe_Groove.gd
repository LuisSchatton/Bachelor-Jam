extends Node3D

var note_count: int

@export var level = "groove"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Conductor.repeat_count = 3
	
	


func _on_conductor_lesson_ended():
	Points.groove_score = Scoring.scoreTotal
	Scoring.scoreTotal = 0
	Global.current_scene = "res://scenes/level/Level_1/Level_Abgabe_Groove.tscn"
	Global.next_scene = "res://scenes/level/Level_1/Level_Abgabe_Fill.tscn"
	get_tree().change_scene_to_file("res://scenes/screens/score_screen.tscn")
