extends Node2D
const STUDENT_SCENE = preload("res://Scenes/student.tscn")
const PROFESSOR_SCENE = preload("res://Scenes/professor.tscn")
@export var annoyedHit: int = 5
var hits = 0
var annoyance: float = 0.0


func _process(delta: float) -> void:
	$TimeLabel.text = str(ceili($LevelTimer.time_left))
	annoyance = max(annoyance - 3 * delta, 0)
	$AnnoyanceBar.value = annoyance
	$SpawnTimer.wait_time = lerp(0.6, 1.5, $LevelTimer.time_left / 45.0)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE and not event.echo:
		$HornSound.play()
		add_annoyance(annoyedHit)
		for area in $Car/HonkZone.get_overlapping_areas():
			area.scatter()


func _on_spawn_timer_timeout() -> void:
	var student = STUDENT_SCENE.instantiate()
	student.position = Vector2(randf_range(290, 345), -20)
	student.speed = randf_range(45,100)
	add_child(student)
	
	
func student_hit() -> void:
	hits += 1
	if hits >= 3:
		$LoseScreen.show_screen()


func _on_level_timer_timeout() -> void:
	$WinScreen.show_screen()

func add_annoyance(amount: float) -> void:
	annoyance += amount
	if annoyance >= 100:
		$LoseScreen.show_screen()


func _on_professor_timer_timeout() -> void:
	var professor = PROFESSOR_SCENE.instantiate()
	if randf() < 0.5:
		professor.position = Vector2(-20, 220)
		professor.direction = 1.0
	else:
		professor.position = Vector2(660, 220)
		professor.direction = -1.0
	add_child(professor)
