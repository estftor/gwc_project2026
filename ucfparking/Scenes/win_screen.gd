extends CanvasLayer
@export_file("*.tscn") var next_level_path: String = ""

func _ready() -> void:
	visible = false
	if next_level_path == "":
		$"VBoxContainer/Win Buttons/Next Level Button".visible = false

func show_screen() -> void:
	visible = true
	get_tree().paused = true

func _on_next_level_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(next_level_path)

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")
