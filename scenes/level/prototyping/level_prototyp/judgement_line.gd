@tool
extends Node2D

signal points_scored()
signal average_accuracy_changed(average_accuracy)

var target_velocity = 45

var black : Color = Color("000000")
var green : Color = Color("00ff00")
var yellow : Color = Color("FFFF00")
var red : Color = Color("FF0000")

var current_color : Color = Color("000000")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _draw():
	
	var black : Color = Color("000000")
	var white : Color = Color("ffffff")
	var green : Color = Color("00ff00")
	var circle_thickness = 2
	
	#draw_circle(Vector2(0, 0), 300, black)
	#draw_circle(Vector2(0, 0), 250, white)
	draw_arc(Vector2(0, 0), 300, 0, 360, 500, current_color, 10, true) 	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_snare_snare_hit(velocity):
	
	queue_redraw()
	
	var average_accuracy
	var normalized_velocity
	
	if velocity <= 50 and velocity >= 40:
		current_color = green
	elif velocity > 50:
		current_color = red
		Global.too_loud += 1
	elif velocity < 40:
		current_color = yellow
		Global.too_quiet += 1  
		
	
	normalized_velocity = _normalizeVelocity(abs(target_velocity - velocity))

	Global.accuracy.append(100 - int(normalized_velocity))

	#print(normalized_velocity)  
	
	average_accuracy = _calculateAverageAccuracy(normalized_velocity)
	
	average_accuracy_changed.emit(average_accuracy)
	
	
	if velocity <= 50 and velocity >= 40:
		Global.score += 1
		points_scored.emit()
		
	
func _calculateAverageAccuracy(velocity):
	
	var sum = 0.0
	var count = Global.accuracy.size()
	
	for value in Global.accuracy:
		sum += float(value)
		
	var accuracy = sum / count
	
	return accuracy 
	
func _normalizeVelocity(velocity, min_val=0, max_val=54, new_min=1, new_max=100):
	
	var normalized_velocity = float(velocity)
	var range = float(max_val - min_val)
	var new_range = float(new_max - new_min)

	normalized_velocity = ((normalized_velocity - float(min_val)) / range) * new_range + new_min
	
	return normalized_velocity


func _on_drum_circle_reached():
	queue_redraw()
