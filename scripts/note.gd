extends Node3D

class_name Note

signal animation_finished()

@onready var animations = $HitAnimation
@onready var note = $"."


var level

var current_path
var current_queue: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	#level = self.get_tree().get_root().get_node("LevelAbgabe")
	
	#var parents = self.get_parent()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _animation(hit):
	
	var parent = note.get_parent_node_3d()
	
	parent.stopped = true
	
	if "hit" == Scoring.hit:
		animations.play("Hit_Animation")
	elif "late" == Scoring.hit:
		animations.play("Late_Animation")
	elif "early" == Scoring.hit:
		animations.play("Early_Animation")


func _on_hit_animation_animation_finished(anim_name):
	animation_finished.emit()
	


