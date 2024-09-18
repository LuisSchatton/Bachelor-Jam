extends Node2D

@onready var snareNote = preload("res://scenes/level/prototyping/level_prototyp_2/snare_note.tscn")
@onready var hihatNote = preload("res://scenes/level/prototyping/level_prototyp_2/hi_hat_note.tscn")
@onready var kickNote = preload("res://scenes/level/prototyping/level_prototyp_2/kick_note.tscn")

var queueSnare = []
var queueHat = []
var queueKick = []

var delta_sum_ = 0.0

var map_bpm = 80
var map_speed = 600.0 

	
var Rockbeat_1 := {
	36: {
		"call": "kick"
	},
	38: {
		"call": "snare",
	},
	45: {
		"call": "hat_closed"
	},
	44: {
		"call": "hat_accent"
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	$"../MidiPlayer".tempo = map_bpm


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta_sum_ += delta
	
	if $"../MidiPlayer".playing == false and delta_sum_ >= 1.0:
		$"../MidiPlayer".play()
	
	var num_children = get_child_count()
	
	#for i in range(num_children):
		#var note = get_child(i)
		#var start_pos = note.position
		#note.scale = Vector2(0.3, 0.3)
		#note.position.x -= delta * map_speed
		
	if queueKick.size() != 0:
		for i in range(queueKick.size()):
			var note = queueKick[i]
			note.scale = Vector2(0.3, 0.3)
			note.position.x -= delta * map_speed
		if queueKick[0].position.x <= 200:
			var note = queueKick[0] 
			$".".remove_child(note)
			queueKick.pop_front()
			
	if queueSnare.size() != 0:
		for i in range(queueSnare.size()):
			var note = queueSnare[i]
			note.scale = Vector2(0.3, 0.3)
			note.position.x -= delta * map_speed
		if queueSnare[0].position.x <= 200:
			var note = queueSnare[0] 
			$".".remove_child(note)
			queueSnare.pop_front()
			
	if queueHat.size() != 0:
		for i in range(queueHat.size()):
			var note = queueHat[i]
			note.scale = Vector2(0.3, 0.3)
			note.position.x -= delta * map_speed
		if queueHat[0].position.x <= 200:
			var note = queueHat[0] 
			$".".remove_child(note)
			queueHat.pop_front()
		

func _on_midi_player_midi_event(channel, event):
	
	if channel.track_name == "":
		
		var current_note = Rockbeat_1.get(event.note)
		
		if current_note == { "call": "kick" } and event.type == 144:
			var kickChild = kickNote.instantiate()
			add_child(kickChild)
			kickChild.expected_time = delta_sum_ + 1.0
			queueKick.push_back(kickChild)
			#print(queueKick)
		elif current_note == { "call": "snare" } and event.type == 144:
			var snareChild = snareNote.instantiate()
			#print(event.type)
			add_child(snareChild)
			snareChild.expected_time = delta_sum_ + 1.0
			queueSnare.push_back(snareChild)
		elif current_note == { "call": "hat_closed"} and event.type == 144:
			var hihatChild = hihatNote.instantiate()
			#print(current_note)
			add_child(hihatChild)
			hihatChild.expected_time = delta_sum_ + 1.0
			queueHat.push_back(hihatChild)
		elif current_note == { "call": "hat_accent"} and event.type == 144:
			var hihatChild = hihatNote.instantiate()
			#print(current_note)
			add_child(hihatChild)
			queueHat.push_back(hihatChild)
		elif current_note != null:
			#print(current_note)
			pass
		else:
			#print("Event note", event.note, "not predefined in animation.")
			pass
	else:
		#print("Unknown track name:", channel.track_name)
		pass
		


func _on_snare_snare_hit(velocity):
	
	if queueSnare.size() != 0:
		var child_node = queueSnare[0]
		
		var expected_time = child_node.expected_time
		
		$".".remove_child(child_node)
		queueSnare.pop_front()
	else:
		pass


func _on_hi_hat_hihat_hit(velocity):
	if queueHat.size() != 0:
		var child_node = queueHat[0]
		
		$".".remove_child(child_node)
		queueHat.pop_front()
	else:
		pass


func _on_kick_kick_hit(velocity):
	if queueKick.size() != 0:
		var child_node = queueKick[0]
		
		$".".remove_child(child_node)
		queueKick.pop_front()
	else:
		pass
		
func _test_hit(expected_time):
	print(abs(expected_time - delta_sum_)) 
	if abs(expected_time - delta_sum_) < 3.2:
		print("late")
	elif abs(expected_time - delta_sum_) <= 3.1:
		print("hit")
	elif delta_sum_ > expected_time + 3.2:
		print("miss")	
