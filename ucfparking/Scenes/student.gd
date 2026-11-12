extends Area2D
@export var speed: float = 60.0
var scattered: bool = false
var scatter_direction: float = 1.0
var hit: bool = false

func _process(delta: float) -> void:
	if hit:
		return
	if scattered:
		position.x += speed * 3 * delta * scatter_direction
	else:
		position.y += speed * delta
		if position.y >= 250:
			get_hit()
		
	if position.x > 660 or position.x < -20:
		queue_free()
		
	

func get_hit() -> void:
	hit = true
	get_parent().student_hit()
	var tween = create_tween()
	tween.tween_property(self, "position:y", position.y - 25, 0.15).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self, "rotation", [-0.8,0.8].pick_random(), 0.3)
	tween.tween_property(self, "modulate:a", 0.0, 0.2)
	tween.tween_callback(queue_free)
	
func scatter() -> void:
	if scattered or hit:
		return
	scattered = true
	scatter_direction = [-1.0, 1.0].pick_random()
	get_parent().student_scattered()
	
	
