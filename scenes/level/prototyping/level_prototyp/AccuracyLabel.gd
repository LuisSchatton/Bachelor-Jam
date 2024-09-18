extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_judgement_line_average_accuracy_changed(average_accuracy):
	
	# Round the average accuracy to two decimal places
	Global.rounded_accuracy = round(average_accuracy * 100) / 100
	
	set_text("⌀ Accuracy: " + str(Global.rounded_accuracy))


