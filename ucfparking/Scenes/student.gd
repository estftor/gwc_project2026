extends Area2D
@export var speed: float = 60.0
var scattered: bool = false
var scatter_direction: float = 1.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if scattered:
		position.x += speed * 3 * delta * scatter_direction
	else:
		position.y += speed * delta
		if position.y >= 280:
			get_parent().student_hit()
			queue_free()
		
	if position.x > 660 or position.x < -20:
		queue_free()
		
		
func scatter() -> void:
	if scattered:
		return
	scattered = true
	scatter_direction = [-1.0, 1.0].pick_random()
	get_parent().student_scattered()
	
	
