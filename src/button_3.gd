extends Button

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if is_visible_in_tree():
		if Input.is_action_just_pressed("AboutMe"):
			_on_pressed()

func _on_pressed() -> void:
	%AudioStreamPlayer.play()
	%CenterContainer.visible = false
	%CenterContainer3.visible = true
