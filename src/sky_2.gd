extends MeshInstance3D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	material_override.set_shader_parameter("mouse_position", get_viewport().get_mouse_position() / 75)
