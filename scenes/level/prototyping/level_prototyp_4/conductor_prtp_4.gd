extends Node2D

# Variables

@onready var note = preload("res://scenes/level/prototyping/level_prototyp_4/note.tscn")
@onready var gridContainer = $"../GridContainer"

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

var Startposition = Vector2(960, 460)
var EndpositionSnare = Vector2(960, 790) # Je nach Note setzen + Conditional nach Position im Layout
var EndpositionHat = Vector2(748, 700) # Gegen Variablen austauschen
var EndpositionKick = Vector2(1169, 700) # Gegen Variablen austauschen


var mapSpeed = Global.mapSpeed
var elapsed_time = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	#var center = get_sprite_center(judgementLine)
	#Startposition = gridContainer.position
	pass
	
# Beat Generation
	
func _on_midi_player_midi_event(channel, event):
	
	if channel.track_name == "":
		
		var current_note = Rockbeat_1.get(event.note)
		
		if current_note == { "call": "kick" } and event.type == 144:
			var kickChild = note.instantiate()
			$".".add_child(kickChild)
			kickChild.Startposition = Startposition
			kickChild.Endposition = EndpositionKick
			queueKick.push_back(kickChild)

		elif current_note == { "call": "snare" } and event.type == 144:
			var snareChild = note.instantiate()

			$".".add_child(snareChild)
			snareChild.Startposition = Startposition
			snareChild.Endposition = EndpositionSnare
			queueSnare.push_back(snareChild)
		elif current_note == { "call": "hat_closed"} and event.type == 144:
			var hihatChild = note.instantiate()
			$".".add_child(hihatChild)
			hihatChild.Startposition = Startposition
			hihatChild.Endposition = EndpositionHat
			queueHat.push_back(hihatChild)
		elif current_note == { "call": "hat_accent"} and event.type == 144:
			var hihatChild = note.instantiate()
			#print(current_note)
			$".".add_child(hihatChild)
			hihatChild.Startposition = Startposition
			hihatChild.Endposition = EndpositionHat
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
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var t
	
	elapsed_time += delta
	t = elapsed_time / mapSpeed
	t = clamp(t, 0.0, 1.0)  # Ensure mapSpeed stays between 0 and 1

	if $"../MidiPlayer".playing == false:
			$"../MidiPlayer".play()

	var num_children = get_child_count()

	if queueKick.size() != 0:
		for i in range(queueKick.size()):
			var kickNote = queueKick[i]
			
		if queueKick[0].position == EndpositionKick:
			var kickNote = queueKick[0] 
			$".".remove_child(kickNote)
			queueKick.pop_front()
			
	if queueSnare.size() != 0:
		for i in range(queueSnare.size()):
			var snareNote = queueSnare[i]
			
		if queueSnare[0].position == EndpositionSnare:
			var snareNote = queueSnare[0] 
			$".".remove_child(snareNote)
			queueSnare.pop_front()
			
	if queueHat.size() != 0:
		for i in range(queueHat.size()):
			var hatNote = queueHat[i]
			
		if queueHat[0].position == EndpositionHat:
			var hatNote = queueHat[0] 
			$".".remove_child(hatNote)
			queueHat.pop_front()
			
			
# Scoring

func _on_snare_snare_hit(velocity):
	
	if queueSnare.size() != 0:
		var child_node = queueSnare[0]
		
		var accuracy = 1 - child_node.t
		
		print(accuracy)
		
		if accuracy <= 0.3 and accuracy >= 0.4:
			print("early")
			$".".remove_child(child_node)
			queueSnare.pop_front()
		elif accuracy < 0.2:
			print("hit")
			$".".remove_child(child_node)
			queueSnare.pop_front()
		elif accuracy < 0.4:
			print("miss")
		
	else:
		pass


func _on_kick_kick_hit(velocity):
	if queueKick.size() != 0:
		var child_node = queueKick[0]
		
		var accuracy = 1 - child_node.t
		
		if accuracy <= 0.3 and accuracy >= 0.4:
			print("early")
			$".".remove_child(child_node)
			queueKick.pop_front()
		elif accuracy < 0.2:
			print("hit")
			$".".remove_child(child_node)
			queueKick.pop_front()
		elif accuracy < 0.4:
			print("miss")
	else:
		pass
		


func _on_hihat_hihat_hit(velocity):
	if queueHat.size() != 0:
		var child_node = queueHat[0]
		
		var accuracy = 1 - child_node.t
		
		print(child_node.t)
		
		if accuracy <= 0.3 and accuracy >= 0.4:
			print("early")
			$".".remove_child(child_node)
			queueHat.pop_front()
		elif accuracy < 0.2:
			print("hit")
			$".".remove_child(child_node)
			queueHat.pop_front()
		elif accuracy < 0.4:
			print("miss")
	else:
		pass
