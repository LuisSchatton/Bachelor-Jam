extends Node2D

# Signals

signal hit(velocity)
signal lesson_ended()

# Variables

var time_array = []


@onready var note_single = preload("res://scenes/elements/notes/notes/note_single.tscn")
@onready var note_rechts_oben = preload("res://scenes/elements/notes/notes/note_top.tscn")
@onready var note_kick = preload("res://scenes/elements/notes/notes/note_kick.tscn")
@onready var notenScript = preload("res://scripts/note_path.gd")


@onready var target_node = $"."

@onready var pathSnare = $"../Highway/PathSnare"
@onready var pathHat = $"../Highway/PathHat"
@onready var pathFloor = $"../Highway/PathFloor"
@onready var pathKick = $"../Highway/PathKick"
@onready var pathRide = $"../Highway/PathRide"
@onready var pathMidTom = $"../Highway/PathMidTom"
@onready var pathHighTom = $"../Highway/PathHighTom"
@onready var pathCrash = $"../Highway/PathCrash"

@onready var hitZoneSnare = $"../Highway/Non_Functional/HitZoneSnare"
@onready var hitZoneHat = $"../Highway/Non_Functional/HitZoneHat"
@onready var hitZoneFloor = $"../Highway/Non_Functional/HitZoneFloor"
@onready var hitZoneCrash = $"../Highway/Non_Functional/HitZoneCrash"
@onready var hitZoneHighTom = $"../Highway/Non_Functional/HitZoneHighTom"
@onready var hitZoneMidTom = $"../Highway/Non_Functional/HitZoneMidTom"
@onready var hitZoneRide = $"../Highway/Non_Functional/HitZoneRide"
@onready var hitZoneKick = $"../Highway/Non_Functional/HitZoneKick"

@onready var scoreLabel = $"../GUI/MarginContainer/VBoxContainer/ScoreLabel"
@onready var accuracyLabel = $"../GUI/MarginContainer/VBoxContainer/AccuracyLabel"

#@onready var metronomeSound = $"../Metronome"
#@onready var metronomeTimer = $"../Metronome2"

var Lesson_1 = {}

var late_timer = 0.0

var repeats = 0
@export var repeat_count = 0

var counter: int

var level_started = false

@export var queueLinks = []
@export var queueRechts = []
@export var queueKick = []

var mapSpeed = Global.mapSpeed
var startTime = 0.0
var elapsed_time = 0.0
var timer: Timer

@export var map_bpm = 89.0

var note_count: int


# Called when the node enters the scene tree for the first time.
func _ready():	
	$"../MidiPlayer".tempo = map_bpm
	
	counter = 0
	
	Points.hits_total = 0
	Points.late_total = 0
	Points.early_total = 0
	Points.misses_total = 0
	
	
	Lesson_1 = {
	39: {
		"call": "links_snare",
		"path": pathSnare,
		"note": "note_links"
	},
	40: {
		"call": "rechts_snare",
		"path": pathSnare,
		"note": "note_rechts"
	},
	36: {
		"call": "kick",
		"path": pathKick,
		"note": "note_kick"
	},	
	42: {
		"call": "hat_closed",
		"path": pathHat,
		"note": "note_rechts"
		},
	47: {
		"call": "high_tom",
		"path": pathHighTom,
		"note": "note_rechts_oben"
	}, 
	45: {
		"call": "mid_tom",
		"path": pathMidTom,
		"note": "note_rechts_oben"
	},
	43: {
		"call": "floor",
		"path": pathFloor,
		"note": "note_rechts"
	},
	48: {
		"call": "crash",
		"path": pathCrash,
		"note": "note_rechts_oben"
	}
}


	
func _on_midi_player_midi_event(channel, event):

	
	if channel.track_name == "Lesson_1":
		
		
		var current_note = Lesson_1.get(event.note) 
		
		note_count += 1
	
		
		if current_note.note == "note_links" and event.type == 144:
			var linksChild = note_single.instantiate()
			var path = current_note.path
			
			var path_follow = _path_follow(path)
			#path_follow.add_child(linksChild)
			path_follow.call_deferred("add_child", linksChild)
			
			
			queueLinks.push_back(path_follow)
		
		elif current_note.note == "note_rechts" and event.type == 144:
			var rechtsChild = note_single.instantiate()
			var path = current_note.path
			
			var path_follow = _path_follow(path)
			#path_follow.add_child(rechtsChild)
			path_follow.call_deferred("add_child", rechtsChild)
			
			rechtsChild.set_scale(rechtsChild.get_scale() * Vector3(-1, 1, 1))
			
			queueRechts.push_back(path_follow)
		
		elif current_note.note == "note_rechts_oben" and event.type == 144:
	
			var rechtsChild = note_rechts_oben.instantiate()
			var path = current_note.path
			
			var path_follow = _path_follow(path)
			#path_follow.add_child(rechtsChild)
			path_follow.call_deferred("add_child", rechtsChild)
		
			queueRechts.push_back(path_follow)
			
			
		elif current_note.note == "note_kick" and event.type == 144:
			var kickChild = note_kick.instantiate()
			var path = current_note.path

			var path_follow = _path_follow(path)
			#path_follow.add_child(kickChild)
			path_follow.call_deferred("add_child", kickChild)

			queueKick.push_back(path_follow)
		elif current_note != null:
			#print(current_note)
			pass
		else:
			print("Event note", event.note, "not predefined.")
			pass
	else:
		print("Unknown track name:", channel.track_name)
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	_delete_completed_nodes(pathSnare, queueLinks)
	_delete_completed_nodes(pathHat, queueLinks)
	_delete_completed_nodes(pathFloor, queueLinks)
	_delete_completed_nodes(pathKick, queueKick)
	_delete_completed_nodes(pathRide, queueLinks)
	_delete_completed_nodes(pathMidTom, queueLinks)
	_delete_completed_nodes(pathHighTom, queueLinks)
	_delete_completed_nodes(pathCrash, queueLinks)
	
	_delete_completed_nodes(pathSnare, queueRechts)
	_delete_completed_nodes(pathHat, queueRechts)
	_delete_completed_nodes(pathFloor, queueRechts)
	_delete_completed_nodes(pathKick, queueKick)
	_delete_completed_nodes(pathRide, queueRechts)
	_delete_completed_nodes(pathMidTom, queueRechts)
	_delete_completed_nodes(pathHighTom, queueRechts)
	_delete_completed_nodes(pathCrash, queueRechts)
	
	_loop_helper($"../MidiPlayer".position)
	
	
	$"../FPS".set_text(str(Engine.get_frames_per_second()))
	
	if level_started == true:
		elapsed_time += delta

	
	

	if elapsed_time >= startTime + mapSpeed:
		
		if $"../Music".playing == false and repeats <= repeat_count:
				$"../Music".play()
				
				await get_tree().create_timer($"../Music".stream.get_length() - mapSpeed).timeout
		
				if $"../MidiPlayer".playing == false:
					$"../MidiPlayer".play()
		elif repeats > repeat_count:
			$"../MidiPlayer".stop()
			
			await get_tree().create_timer(mapSpeed).timeout
			
			$"../Music".stop()
			
			print(note_count)
			lesson_ended.emit()
			

	
			


func _path_follow(path):
	var path_follow = PathFollow3D.new()
	path_follow.set_script(notenScript)
	path.call_deferred("add_child", path_follow)
	path_follow.stopped = false
	path_follow.elapsed_time = 0
	
	#print("PathFollow3D node created with ID: %d" % path_follow.get_instance_id())

	
	return path_follow
	
# Scoring

func _scoring(queues, path, velocity, hitZone):
	
	var current_path = Scoring._find_current_path(queues)
	var score = Scoring._scoring(current_path)
	var hit_time = Scoring.hit
	var current_queue = Scoring.current_queue
	
	hitZone._animate(hit_time)
	
	
	scoreLabel.set_text(str(Scoring.scoreTotal))
	accuracyLabel.set_text(str("%.1f" % Scoring.accuracy) + "%")
	
	
	
	hit.emit(velocity)
	
	var children_to_remove = []
	
	if score != null and current_queue != null:
		var current_path_id = current_path.get_instance_id()
		for child in path.get_children():
			if child.get_instance_id() == current_path_id:
				var current_note = current_path.get_node("Note")
				var animation_finished = current_note.animation_finished
				current_note._animation(hit_time)
				
				await animation_finished
				
				children_to_remove.append(child)
					
		for child in children_to_remove:
			if child.get_parent() == path:  # Check if the child is still part of the path
				path.call_deferred("remove_child", child)
				current_queue.pop_front()
	
		#_delete_completed_nodes(path, current_queue)
		
	 
					
func _delete_completed_nodes(path, queue):
	#print(queueRechts)
	var nodes_to_remove = []
	for note in queue:
		if note.progress_ratio == 1.0:
			nodes_to_remove.append(note)
			Points.misses_total += 1
	
	for note in nodes_to_remove:
		if note.get_parent() == path:
			path.call_deferred("remove_child", note)
			queue.erase(note)
		
		
# Inputs

		
func _on_snare_snare_hit(velocity):
	var queues = [queueLinks, queueRechts]
	_scoring(queues, pathSnare, velocity, hitZoneSnare)	
		

func _on_ride_ride_hit(velocity):
	pass # Replace with function body.
	

func _on_hihat_hihat_hit(velocity):
	var queues = [queueLinks, queueRechts]
	_scoring(queues, pathHat, velocity, hitZoneHat)	


func _on_kick_kick_hit(velocity):
	var queues = [queueKick]
	_scoring(queues, pathKick, velocity, hitZoneKick)	


func _on_high_tom_high_tom_hit(velocity):
	var queues = [queueLinks, queueRechts]
	_scoring(queues, pathHighTom, velocity, hitZoneHighTom)	
	

func _on_mid_tom_mid_tom_hit(velocity):
	var queues = [queueLinks, queueRechts]
	_scoring(queues, pathMidTom, velocity, hitZoneMidTom)	

func _on_low_tom_floor_tom_hit(velocity):
	var queues = [queueLinks, queueRechts]
	_scoring(queues, pathFloor, velocity, hitZoneFloor)	

func _on_crash_crash_hit(velocity):
	var queues = [queueLinks, queueRechts]
	_scoring(queues, pathCrash, velocity, hitZoneCrash)	




func _on_midi_player_looped():
	repeats += 1
	
func _loop_helper(time):
	time_array.append(time)
	
	if time_array.size() > 5:
		time_array.pop_front()


func _on_labels_start_animation_finished():
	level_started = true
	
#func _get_note_score():
	
