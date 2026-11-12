extends Node2D
const STUDENT_SCENE = preload("res://Scenes/student.tscn")
const PROFESSOR_SCENE = preload("res://Scenes/professor.tscn")
const GRADES = ["A", "B", "C", "F"]
var professorHonked: bool = false
@export var annoyedHit: int = 10
@export var wastedHonk: int = 15
var hits = 0
var annoyance: float = 0.0
var scatteredCount: int = 0


func _process(delta: float) -> void:
	$TimeLabel.text = str(ceili($LevelTimer.time_left))
	annoyance = max(annoyance - 2 * delta, 0)
	$AnnoyanceBar.value = annoyance
	if annoyance >= 70:
		$AnnoyanceBar.modulate = Color.RED
	elif annoyance >= 50:
		$AnnoyanceBar.modulate = Color.YELLOW
	else:
		$AnnoyanceBar.modulate = Color.WHITE
	$SpawnTimer.wait_time = lerp(0.6, 1.5, $LevelTimer.time_left / 45.0)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE and not event.echo:
		$HornSound.play()
		$Car/Sprite2D.scale = Vector2(0.96, 0.96)
		create_tween().tween_property($Car/Sprite2D, "scale", Vector2(0.8,0.8), 0.12)
		var ring = $Car/HonkZone/HonkRing
		ring.modulate.a = 1.0
		ring.scale = Vector2(0.3, 0.3)
		var tween = create_tween().set_parallel().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		tween.tween_property(ring, "scale", Vector2.ONE, 0.3)
		tween.tween_property(ring, "modulate:a", 0.0, 0.3)
		scatteredCount = 0
		professorHonked = false
		for area in $Car/HonkZone.get_overlapping_areas():
			area.scatter()
			
		if professorHonked:
			add_annoyance(annoyedHit)
		elif scatteredCount == 0:
			add_annoyance(wastedHonk)
		elif scatteredCount == 1:
			add_annoyance(annoyedHit)
		else:
			annoyance = max(annoyance - 5 * scatteredCount, 0)


func _on_spawn_timer_timeout() -> void:
	var student = STUDENT_SCENE.instantiate()
	student.position = Vector2(randf_range(290, 345), -20)
	student.speed = randf_range(45,100)
	add_child(student)
	
	
func student_hit() -> void:
	hits += 1
	$HitFlash.modulate.a = 0.5
	create_tween().tween_property($HitFlash, "modulate:a", 0.0, 0.25)
	$GradeLabel.text = "Grade: " + GRADES[min(hits,3)]
	if hits >= 3:
		$LoseScreen.show_screen()


func _on_level_timer_timeout() -> void:
	$WinScreen/VBoxContainer/Label.text = "You Win! Grade: " + GRADES[hits]
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

func student_scattered() -> void:
	scatteredCount += 1
