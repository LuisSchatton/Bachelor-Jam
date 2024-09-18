extends Control

signal mid_tom_hit(velocity)

@export var stream: AudioStream

# @onready var snareSound = 

func _ready():
	OS.open_midi_inputs()
	
func _input(event):
	if event is InputEventMIDI and event.pitch == 53:
			if event.velocity > 0:
				var velocity = event.velocity
				AudioManager.play_sound(stream)
				
				mid_tom_hit.emit(velocity)
				
func _process(delta):
	pass
