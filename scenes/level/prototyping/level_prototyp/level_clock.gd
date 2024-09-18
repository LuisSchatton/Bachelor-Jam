extends Node2D

var time_left = 0
var clock = 0

var grey : Color = Color("d2d2d2")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	draw_arc(Vector2(100, 100), 50, deg_to_rad(270), deg_to_rad(clock), 500, grey, 10, true) 	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_left = $LevelTimer.get_time_left()
	clock = _timeToDegrees(time_left)
	queue_redraw()

func _timeToDegrees(time_left, min_val=1, max_val=30, new_min=-90, new_max=270):
	
	var degreesArc = ((time_left - min_val) / (max_val - min_val)) * (new_max - new_min) + new_min
	
	return degreesArc


func _on_level_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/level/prototyping/level_prototyp/game_over_prototyp.tscn")
