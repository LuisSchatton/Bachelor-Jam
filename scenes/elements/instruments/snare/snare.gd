extends Control

signal snare_hit(velocity)

@export var stream: AudioStream 

func _ready():
	OS.open_midi_inputs()
	
func _input(event):
	if event is InputEventMIDI and event.pitch == 41:
			if event.velocity > 0:
				var velocity = event.velocity
				AudioManager.play_sound(stream)

				
				snare_hit.emit(velocity)
				
	if event is InputEventMIDI and event.pitch == 42:
		pass
		
func _process(delta):
	pass


