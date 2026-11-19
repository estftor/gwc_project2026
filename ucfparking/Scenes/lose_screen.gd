extends CanvasLayer

# Gets the timer label from the current scene. If the scene doesn't have a timer label, it returns Null
@onready var timer_label = get_node_or_null("../Timer/Timer label")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	# Checks if timer label exists in the current scene.
	if timer_label != null:
		timer_label.time_up.connect(show_screen)


func show_screen() -> void:
	visible = true
	get_tree().paused = true



func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")
