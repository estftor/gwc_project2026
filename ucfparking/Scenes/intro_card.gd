extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	

func _input(event: InputEvent) -> void:
	if visible and event is InputEventKey and event.pressed and event.keycode == KEY_SPACE and not event.echo:
		visible = false
		get_tree().paused = false
		get_viewport().set_input_as_handled()
