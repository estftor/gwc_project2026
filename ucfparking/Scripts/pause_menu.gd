extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
func _input(event: InputEvent) -> void:
	
	# Godot built in pause press
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused
	
