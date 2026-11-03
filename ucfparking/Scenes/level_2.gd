extends Node2D
const STUDENT_SCENE = preload("res://Scenes/student.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE and not event.echo:
		print("HONK!")
		for area in $Car/HonkZone.get_overlapping_areas():
			area.scatter()


func _on_spawn_timer_timeout() -> void:
	var student = STUDENT_SCENE.instantiate()
	student.position = Vector2(randf_range(290, 345), -20)
	add_child(student)
