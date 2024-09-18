@tool
extends Node2D

signal circle_reached()

@export var size : float = 0

@export var target_size : int = 0

var grey : Color = Color("d2d2d2")

@export var animation_speed : float = 500

var max_size_drum = 400
var min_size_drum = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _draw():
	# Four circles for the 2 eyes: 2 white, 2 grey.
	draw_arc(Vector2(0, 0), size, 0, 360, 500, grey, 20, true) 	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if size < target_size:
		size += animation_speed * float(delta)
		queue_redraw()
	elif size >= target_size:
		circle_reached.emit()
		target_size = 0
		size = 0
		queue_redraw()
	else:
		size = 0



func _on_snare_snare_hit(velocity):
	
	var normalized_velocity
	var num_children = $"../DrumContainer".get_child_count()
	
	for i in range(num_children):
		var child_node = $"../DrumContainer".get_child(i)
		
		if child_node == null:
			pass
		else:
			normalized_velocity = _normalizeVelocity(float(velocity))
			child_node.target_size = normalized_velocity
			#print(str(child_node) + "TS: " + str(child_node.target_size))
	
	
	

func _normalizeVelocity(velocity, min_val=1, max_val=99, new_min=min_size_drum, new_max=max_size_drum):
	
	var normalized_velocity = ((velocity - min_val) / (max_val - min_val)) * (new_max - new_min) + new_min
	#print(normalized_velocity)
	
	return normalized_velocity
