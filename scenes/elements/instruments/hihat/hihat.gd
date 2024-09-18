extends Control

signal hihat_hit(velocity)

@export var stream: AudioStream

func _ready():
	OS.open_midi_inputs()
	
func _input(event):
	if event is InputEventMIDI and event.pitch == 45:
			if event.velocity > 0:
				var velocity = event.velocity
				AudioManager.play_sound(stream)
				
				hihat_hit.emit(velocity)
				
	elif event is InputEventMIDI and event.pitch == 46:
		if event.velocity > 0:
			var velocity = event.velocity
			AudioManager.play_sound(stream)
	
			hihat_hit.emit(velocity)
				
func _process(delta):
	pass
