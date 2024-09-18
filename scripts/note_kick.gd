extends PathFollow3D

var elapsed_time: float = 0.0

@export var queue: String

# Called when the node enters the scene tree for the first time.
func _ready():
	$".".set_progress_ratio(0.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	elapsed_time += delta
	
	if elapsed_time < Global.mapSpeed:
		$".".set_progress_ratio(elapsed_time / Global.mapSpeed)
	else:
		$".".set_progress_ratio(1.0)
