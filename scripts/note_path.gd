extends PathFollow3D


var elapsed_time: float = 0.0
var stopped: bool = false
var animation_finished: bool 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	self.set_progress_ratio(0.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if stopped == false:
		elapsed_time += delta
		
		if elapsed_time < Global.mapSpeed:
			self.set_progress_ratio(elapsed_time / Global.mapSpeed)
		else:
			self.set_progress_ratio(1.0)
	else:
		print(stopped)
		pass
