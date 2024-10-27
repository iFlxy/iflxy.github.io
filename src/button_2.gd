extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_visible_in_tree():
		if Input.is_action_just_pressed("YouTube"):
			_on_pressed()



func _on_pressed() -> void:
	%AudioStreamPlayer.playsound(%AudioStreamPlayer.PRESS_SOUND)
	if OS.has_feature('JavaScript'):
		JavaScriptBridge.eval("""
			window.open('https://www.youtube.com/@iFlxy', '_blank').focus();
		""")
