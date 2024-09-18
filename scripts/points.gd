extends Node

var hits_total: int
var early_total: int
var late_total: int
var misses_total: int

var rudiments_score: int = 0
var groove_score: int = 0
var fill_score: int = 0

var score_total: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _scoreTotal():
	score_total = rudiments_score + groove_score + fill_score
