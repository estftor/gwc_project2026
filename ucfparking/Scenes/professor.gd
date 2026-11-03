extends Area2D
@export var speed: float = 60.0
var direction: float = 1.0
@export var professorHit: int = 25

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta * direction
	if position.x > 680 or position.x < -40:
		queue_free()
		
func scatter() -> void:
	$Sprite2D.modulate = Color.RED
	get_parent().add_annoyance(professorHit)
	get_parent().professorHonked = true
