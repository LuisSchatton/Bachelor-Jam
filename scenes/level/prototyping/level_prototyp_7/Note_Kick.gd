extends Sprite2D

var expectet_time = Global.mapSpeed

@export var Startposition: Vector2
@export var Endposition: Vector2

@export var t: float

var startSize = Vector2(0.1, 0.1)
var endSize = Vector2(0.3, 0.3)

var elapsed_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	elapsed_time += delta
	t = elapsed_time / expectet_time
	t = clamp(t, 0.0, 1.0)  # Ensure mapSpeed stays between 0 and 1
	
	#$".".position = Startposition.lerp(Endposition, t)
	$".".scale = startSize.lerp(endSize, t)
