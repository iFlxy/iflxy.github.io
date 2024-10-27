extends MeshInstance3D

var is_hovering: bool = false
var unshake := Vector3(0, 0.768, 0)
var target_position := unshake
var amnt = 0.19
var jump_height = 9.5
var jump_speed = 10.0
var is_prsd_step: bool = false
var is_prsd_complete: bool = false
var was_anim_played: bool = false
var was_anim_ended: bool = false
var target_color: float = 0.375
var current_color: float = 1.0
var lerp_speed: float = 0.5
var abtmevis: float = 0.0

@onready var material: ShaderMaterial = $"../Sky2".material_override

func _ready() -> void:
	material.set_shader_parameter("overlay_alpha", current_color)
	%AboutMe.modulate = Color(255, 255, 255, abtmevis)
	position = unshake
	%Timer.timeout.connect(_on_timer_timeout)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if is_hovering and !was_anim_played:
			is_prsd_step = true
	elif event.is_action_released("click"):
		if is_hovering and is_prsd_step and !was_anim_played:
			is_prsd_complete = true
			on_click_jump()

func _process(delta: float) -> void:
	if is_hovering and !was_anim_played:
		rotation_degrees.y += 180 * delta
	elif !is_hovering and !was_anim_played:
		rotation_degrees.y += 75 * delta
	if was_anim_played:
		rotation_degrees.y += 660 * delta

		if position.y >= (unshake.y + jump_height - 5) and !was_anim_ended:
			current_color = lerp(current_color, target_color, lerp_speed * delta)
			material.set_shader_parameter("overlay_alpha", current_color)
			if !%AboutMe.visible:
				%AboutMe.visible = true
			else:
				abtmevis += 0.7 * delta
				abtmevis = clamp(abtmevis, 0.0, 1.0)
			%AboutMe.modulate = Color(255, 255, 255, abtmevis)

	position = position.lerp(target_position, 5 * delta)
	
func _on_star_col_box_mouse_entered() -> void:
	is_hovering = true

func _on_star_col_box_mouse_exited() -> void:
	is_hovering = false

func _on_timer_timeout():
	if is_hovering and !was_anim_played:
		target_position = Vector3(
			unshake.x + randf_range(-amnt, amnt),
			unshake.y + randf_range(-amnt, amnt),
			unshake.z + randf_range(-amnt, amnt)
		)
	elif !is_hovering and !was_anim_played:
		target_position = unshake

func on_click_jump() -> void:
	%AudioStreamPlayer.playsound(%AudioStreamPlayer.PRESS_SOUND)
	was_anim_played = true
	%ClickInfo.visible = false
	target_position = unshake - Vector3(0, 1.5, 0)
	await get_tree().create_timer(0.82).timeout
	target_position = unshake + Vector3(0, jump_height, 0)
