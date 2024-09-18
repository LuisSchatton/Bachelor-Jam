extends Node3D

@onready var HitAnimation = $HitAnimation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _animate(hit):
	if hit != null:
		if hit == "empty":
			HitAnimation.play("Empty_Animation")
		if hit == "hit":
			HitAnimation.play("Hit_Animation")
		if hit == "late":
			HitAnimation.play("Late_Animation")
		if hit == "early":
			HitAnimation.play("Early_Animation")
