extends Node3D

@onready var start_animation = $AnimationPlayer

signal start_animation_finished

@onready var level: String

# Called when the node enters the scene tree for the first time.
func _ready():
	level = $"..".level
	_start_animation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _start_animation():
	await get_tree().create_timer(1).timeout
	
	if level == "rudiment":
		start_animation.play("snaresprite_start")
	
	elif level == "groove":
		start_animation.play("snaresprite_start")
		start_animation.queue("hihatsprite_start")
		start_animation.queue("kicksprite_start")
		
	elif level == "fill":
		start_animation.play("crashsprite_start")
		start_animation.queue("hightomsprite_start")
		start_animation.queue("midtomsprite_start")
		start_animation.queue("floorsprite_start")
		
	elif level == "groove_fill":
		start_animation.play("snaresprite_start")
		start_animation.queue("hihatsprite_start")
		start_animation.queue("kicksprite_start")
		start_animation.queue("floorsprite_start")
		start_animation.queue("crashsprite_start")
		start_animation.queue("hightomsprite_start")
		start_animation.queue("midtomsprite_start")
		start_animation.queue("ridesprite_start")
	else:
		pass

func _on_animation_player_animation_finished(anim_name):
	start_animation_finished.emit()
