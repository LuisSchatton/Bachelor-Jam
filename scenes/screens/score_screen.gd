extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/RudimentsScore.set_text(str(Points.rudiments_score))
	$MarginContainer/VBoxContainer/FillsScore.set_text(str(Points.fill_score))
	$MarginContainer/VBoxContainer/GroovesScore.set_text(str(Points.groove_score))
	
	$MarginContainer2/VBoxContainer/Hits.set_text("x" + str(Points.hits_total))
	$MarginContainer2/VBoxContainer/Early.set_text("x" + str(Points.early_total))
	$MarginContainer2/VBoxContainer/Late.set_text("x" + str(Points.late_total))
	$MarginContainer2/VBoxContainer/Misses.set_text("x" + str(Points.misses_total))
	
	Points._scoreTotal()
	
	$MarginContainer3/TotalScore.set_text(str(Points.score_total))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_crash_crash_hit(velocity):
	get_tree().change_scene_to_file(str(Global.current_scene))


func _on_ride_ride_hit(velocity):
	get_tree().change_scene_to_file(str(Global.next_scene))
