extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_snare_snare_hit(velocity):
	$SnareAnimationHit.play("SnareAnimationHit")


func _on_hi_hat_hihat_hit(velocity):
	$CymbalAnimationHit.play("HitAnimation")


func _on_kick_kick_hit(velocity):
	$KickAnimationHit.play("KickAnimationHit")
