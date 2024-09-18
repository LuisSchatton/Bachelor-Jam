extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	$ScorePerfect.set_text(str(Global.score))
	$ScoreTooLoud.set_text(str(Global.too_loud))
	$ScoreTooQuiet.set_text(str(Global.too_quiet))
	$ScoreAccuracy.set_text(str(Global.rounded_accuracy))
	print(str(Global.rounded_accuracy))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
