extends MeshInstance3D

var oneshot: bool = false

func _process(delta):
	rotation.y += delta * 2.2
	
func _input(event: InputEvent) -> void:
	if !oneshot:
		if event is InputEventKey or event is InputEventMouseButton:
			%AudioStreamPlayer.play()
			oneshot = true
			$"../AnimationPlayer".play("jump")
		
