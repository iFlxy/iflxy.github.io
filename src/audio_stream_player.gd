extends AudioStreamPlayer

var PRESS_SOUND = preload("res://click.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func playsound(sound):
	stream = sound
	playing = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
