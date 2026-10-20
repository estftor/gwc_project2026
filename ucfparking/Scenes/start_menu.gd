extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func _on_settings_button_pressed() -> void:
	$"Buttons container".visible = false
	$"Settings Menu".visible = true

func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _ready() -> void:
	$"Settings Menu".visible = false

func _on_setting_exit_button_pressed() -> void:
	$"Settings Menu".visible = false
	$"Buttons container".visible = true
