extends Node2D

var grey : Color = Color("d2d2d2")
var green : Color = Color("00ff00")

var current_color = grey

func _draw():
	draw_arc(Vector2(0, 0), 200, 0, 360, 500, current_color, 20, true)
	pass
	
	
func _on_midi_player_midi_event(channel, event):
	current_color = green
	print(channel, event)
	queue_redraw()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



