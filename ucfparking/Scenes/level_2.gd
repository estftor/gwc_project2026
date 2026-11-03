extends Node2D
const STUDENT_SCENE = preload("res://Scenes/student.tscn")
var hits = 0
var annoyance: float = 0.0


func _process(delta: float) -> void:
	$TimeLabel.text = str(ceili($LevelTimer.time_left))
	annoyance = max(annoyance - 3 * delta, 0)
	$AnnoyanceBar.value = annoyance

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE and not event.echo:
		print("HONK!")
		add_annoyance(10)
		for area in $Car/HonkZone.get_overlapping_areas():
			area.scatter()


func _on_spawn_timer_timeout() -> void:
	var student = STUDENT_SCENE.instantiate()
	student.position = Vector2(randf_range(290, 345), -20)
	add_child(student)
	
	
func student_hit() -> void:
	hits += 1
	print("Hits: ", hits)
	if hits >= 3:
		$LoseScreen.show_screen()


func _on_level_timer_timeout() -> void:
	$WinScreen.show_screen()

func add_annoyance(amount: float) -> void:
	annoyance += amount
	if annoyance >= 100:
		$LoseScreen.show_screen()
