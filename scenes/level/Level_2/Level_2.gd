extends Node3D

@export var level = "groove_fill"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Conductor.repeat_count = 7


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
