extends Label


signal time_up

@export var start_time: float = 60.0

var time_left: float = start_time
var running: bool = true

func _ready() -> void:
	time_left = start_time
	text = format_time(time_left)

func _process(delta: float) -> void:
	if not running:
		return

	time_left -= delta

	if time_left <= 0.0:
		time_left = 0.0
		running = false
		time_up.emit()

	text = format_time(time_left)

func format_time(t: float) -> String:
	var minutes := int(t / 60.0)
	var seconds := int(t) % 60
	return "%02d:%02d" % [minutes, seconds]

func start() -> void:
	running = true

func stop() -> void:
	running = false

func reset() -> void:
	time_left = start_time
	running = true
