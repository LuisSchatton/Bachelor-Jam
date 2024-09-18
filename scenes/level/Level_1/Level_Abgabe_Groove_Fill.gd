extends Node3D


@export var level = "groove_fill"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Conductor.repeat_count = 7


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_conductor_lesson_ended():
	Points.score_total += Scoring.scoreTotal
	Scoring.scoreTotal = 0
	Global.current_scene = "res://scenes/level/Level_1/Level_Abgabe_Groove_Fill.tscn"
	Global.next_scene = "res://scenes/screens/main_menu.tscn"
	get_tree().change_scene_to_file("res://scenes/screens/score_screen.tscn")
