extends Node2D

# Variables

@onready var note_links = preload("res://scenes/level/prototyping/level_prototyp_5/note_links.tscn")
@onready var note_rechts = preload("res://scenes/level/prototyping/level_prototyp_5/note_rechts.tscn")
@onready var metronomeSound = $"../Metronome"
@onready var metronomeTimer = $"../Metronome2"

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

var queueSnare = []
var queueHat = []
var queueKick = []

var queueLinks = []
var queueRechts = []

var current_queue

var mapSpeed = Global.mapSpeed
var elapsed_time = 0.0

@export var map_bpm = 120.0


# Called when the node enters the scene tree for the first time.
func _ready():	
	$"../MidiPlayer".tempo = map_bpm
	

	
func _on_midi_player_midi_event(channel, event):
	
	if channel.track_name == "":
		
		var current_note = Rockbeat_1.get(event.note)
		
		if current_note == { "call": "snare" } and event.type == 144:
			var linksChild = note_links.instantiate()
			$"../PathLinks".add_child(linksChild)
			queueLinks.push_back(linksChild)
		elif current_note == { "call": "rechts" } and event.type == 144:
			var rechtsChild = note_rechts.instantiate()
			$"../PathRechts".add_child(rechtsChild)
			queueRechts.push_back(rechtsChild)
		elif current_note != null:
			#print(current_note)
			pass
		else:
			print("Event note", event.note, "not predefined in animation.")
			pass
	else:
		#print("Unknown track name:", channel.track_name)
		pass
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$"../FPS".set_text(str(Engine.get_frames_per_second()))

	elapsed_time += delta
	
	if $"../MidiPlayer".playing == false and elapsed_time >= 1.0:
		$"../MidiPlayer".play()
		metronomeTimer.set_wait_time(0.917)
		metronomeTimer.start()
			


	var num_children = get_child_count()

	if queueLinks.size() != 0:
		for i in range(queueLinks.size()):
			var linksNote = queueLinks[i]
			
		if queueLinks[0].progress_ratio == 1.0:
			var linksNote = queueLinks[0] 
			$"../PathLinks".remove_child(linksNote)
			queueLinks.pop_front()
			$"../MarginContainer/ScoreLabel".set_text("Miss")
			
	if queueRechts.size() != 0:
		for i in range(queueRechts.size()):
			var rechtsNote = queueRechts[i]
			
		if queueRechts[0].progress_ratio == 1.0:
			var rechtsNote = queueRechts[0] 
			$"../PathRechts".remove_child(rechtsNote)
			queueRechts.pop_front()
			$"../MarginContainer/ScoreLabel".set_text("Miss")
			
# Scoring

#func _on_snare_snare_hit(velocity):
	#
	#if queueLinks.size() != 0:
		#var child_node = queueLinks[0]
		#
		#var accuracy = 1 - child_node.progress_ratio
		#
		#print(accuracy)
		#
		#if accuracy <= 0.3 and accuracy >= 0.4:
			#print("early")
			#$"../PathLinks".remove_child(child_node)
			#queueLinks.pop_front()
		#elif accuracy < 0.2:
			#print("hit")
			#$"../PathLinks".remove_child(child_node)
			#queueLinks.pop_front()
			#$"../Animation".play("Animation_Hit")
		#elif accuracy < 0.4:
			#print("miss")
			#$"../Animation".play("Animation_Hit_Grey")
			#
	#elif queueRechts.size() != 0:
		#var child_node = queueRechts[0]
		#
		#var accuracy = 1 - child_node.progress_ratio
		#
		#if accuracy <= 0.3 and accuracy >= 0.4:
			#print("early")
			#$"../PathRechts".remove_child(child_node)
			#queueRechts.pop_front()
		#elif accuracy < 0.2:
			#print("hit")
			#$"../PathRechts".remove_child(child_node)
			#queueRechts.pop_front()
			#$"../Animation".play("Animation_Hit")
		#elif accuracy < 0.4:
			#print("miss")
			#$"../Animation".play("Animation_Hit_Grey")
		#
	#else:
		#$"../Animation".play("Animation_Hit_Grey")
		
func _on_snare_snare_hit(velocity):
	var queues = [queueLinks, queueRechts]
	
	var current_note = _find_closest_note(queues)
	
	if current_note != null:
		var score = _scoring(current_note)
		var parent = current_note.get_parent()
		
		if score != null:
			$"../MarginContainer/ScoreLabel".set_text(str(score))
			parent.remove_child(current_note)
			current_queue.pop_front()
	else:
		print("No Note")

func _find_closest_note(queues):
	var current_note = null
	var highest_progress_ratio = -1.0
	
	for queue in queues:
		for obj in queue:
			if obj.progress_ratio > highest_progress_ratio:
				highest_progress_ratio = obj.progress_ratio
				current_note = obj 
				current_queue = queue
				
	return current_note
		
		
		
func _scoring(current_note):
	var accuracy = current_note.progress_ratio
	
	var score
	
	if 0.95 >= accuracy and accuracy >= 0.8:
		if accuracy >= 0.9:
			print("Hit")
			$"../Animation".play("Animation_Hit")
			score = 100
			
		elif accuracy < 0.9 and accuracy > 0.8:
			print("Close")
			$"../Animation".play("Animation_Hit")
			score = 80
			
	else:
		$"../Animation".play("Animation_Hit_Grey")
		
		score = null
		
	return score
	

func _on_metronome_2_timeout():
	metronomeSound.play()
	metronomeTimer.set_wait_time(60 / map_bpm)
	metronomeTimer.start()
