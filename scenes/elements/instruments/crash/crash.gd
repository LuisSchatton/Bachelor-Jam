extends Control

signal crash_hit(velocity)

@export var stream: AudioStream

func _ready():
	OS.open_midi_inputs()
	
func _input(event):
	if event is InputEventMIDI and event.pitch == 65:
			if event.velocity > 0:
				var velocity = event.velocity
				AudioManager.play_sound(stream)
				
				crash_hit.emit(velocity)
				
func _process(delta):
	pass
