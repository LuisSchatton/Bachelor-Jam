extends Control

signal floor_tom_hit(velocity)

@export var stream: AudioStream

var queueSound = []

func _ready():
	OS.open_midi_inputs()
	
func _input(event):
	
	
	if event is InputEventMIDI and event.pitch == 57:
			if event.velocity > 0:
				var velocity = event.velocity
				
				AudioManager.play_sound(stream)
				
				floor_tom_hit.emit(velocity)
				
func _process(delta):
	if queueSound.size() != 0:
		for i in range(queueSound.size()):
			var sound = queueSound[i]

