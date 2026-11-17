extends Node2D

@onready var car = $Car
@onready var spot = $ParkingSpot
@onready var end_ui = $EndUI

func _ready() -> void:
	end_ui.visible = false
	$EndUI/VBoxContainer/GradeLabel.text = "Final Grade: " + GameState.GRADES[GameState.grade_idx]
	park_car()
	

func show_ending() -> void:
	end_ui.visible = true

# Drive right to the spot, turn to face up, pull in, then show the ending
func park_car() -> void:
	var tween = create_tween()
	tween.tween_property(car, "position:x", spot.position.x, 1.5)
	tween.tween_property(car, "rotation_degrees", 0.0, 0.4)
	tween.tween_property(car, "position:y", spot.position.y, 1.0)
	tween.tween_callback(show_ending)
	


func _on_play_again_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")
	
	
