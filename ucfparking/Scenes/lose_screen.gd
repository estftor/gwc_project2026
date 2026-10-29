extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

#TEMP: Press L to lose, for testing. Delete when the real lose condition exists.
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_L:
		if not get_tree().paused:
			show_screen()

func show_screen() -> void:
	visible = true
	get_tree().paused = true



func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")
