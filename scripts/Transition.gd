extends CanvasLayer

export (float) var transition_time = 0.25
onready var overlay = $ColorRect
# Called when the node enters the scene tree for the first time.

func fade_to(target):
	overlay.set_size(get_viewport().size)
	$Tween.interpolate_property(overlay, "color", 
		Color(0, 0, 0, 0),
		Color(0, 0, 0, 1),
		 transition_time / 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	# Wait for the tweening to be completed (fade in)
	yield($Tween, "tween_completed")
	get_tree().change_scene(target)
	$Tween.interpolate_property(overlay, "color", 
		Color(0, 0, 0, 1),
		Color(0, 0, 0, 0),
		 1.0, transition_time / 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	# Wait for the fadeout to complete
	yield($Tween, "tween_completed")
	overlay.set_size(Vector2(0,0))