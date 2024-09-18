extends Control

signal ride_hit(velocity)

@export var stream: AudioStream

func _ready():
	OS.open_midi_inputs()
	
func _input(event):
	if event is InputEventMIDI and event.pitch == 72:
			if event.velocity > 0:
				var velocity = event.velocity
				AudioManager.play_sound(stream)
				
				ride_hit.emit(velocity)
				
func _process(delta):
	pass
