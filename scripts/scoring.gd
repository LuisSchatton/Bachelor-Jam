extends Node

@onready var hit_effect = preload("res://scenes/level/Level_1/hit_vfx.tscn")

var hit_score = 1200
var early_score = 1000
var late_score = 1000


var accuracy_values = []
var accuracy: float

var timing: float
var hit: String


var current_queue

var scoreTotal = 0

func _process(delta):
	var average_accuracy = get_average_accuracy()
		
		

func _find_current_path(queues):
	var current_path = null
	var highest_progress_ratio = -1.0
	
	for queue in queues:
		for obj in queue:
			if obj.progress_ratio > highest_progress_ratio:
				highest_progress_ratio = obj.progress_ratio
				current_path = obj 
				current_queue = queue
			elif obj == null:
				current_path = null
				print("test")
	
				
	return current_path
		
		
		
func _scoring(current_path):
	
	var score
	
	if current_path != null:
		
		if current_path.progress_ratio >= 0.96:
			if current_path.progress_ratio >= 0.99:
				# Late hit
				score = late_score
				scoreTotal += score
				hit = "late"
				Points.late_total += 1
			elif current_path.progress_ratio >= 0.98:
				# Hit
				score = hit_score
				scoreTotal += score
				hit = "hit"
				Points.hits_total += 1
			elif current_path.progress_ratio >= 0.96:
				# Early hit
				score = early_score
				scoreTotal += score
				Points.early_total += 1
				hit = "early"
					
				accuracy = add_accuracy_value(current_path.progress_ratio)
			
			
			var normalized_offset = get_timing_offset()
			timing = normalized_offset
				
	
	elif current_path == null:
			
			hit = "empty"
			score = null
			
	return score
	
func calculate_accuracy(progress_ratio):
	# Calculate the accuracy based on the progress_ratio
	var accuracy = max(0, min(100, 100 - abs(progress_ratio - 0.95) * 200))
	return accuracy

func add_accuracy_value(progress_ratio):
	var accuracy = calculate_accuracy(progress_ratio)
	accuracy_values.append(accuracy)
	return accuracy

func get_average_accuracy():
	if accuracy_values.size() == 0:
		return 0.0  # Avoid division by zero
	var total_accuracy = 0.0
	for value in accuracy_values:
		total_accuracy += value
	return total_accuracy / accuracy_values.size()
	
func get_timing_offset():
	var total_offset = 0.0
	for progress_ratio in accuracy_values:
		total_offset += progress_ratio - 0.95
	var average_offset = total_offset / accuracy_values.size()
	var normalized_offset = average_offset / 0.95
	
	return normalized_offset
	
##func get_note_score():
	
	
