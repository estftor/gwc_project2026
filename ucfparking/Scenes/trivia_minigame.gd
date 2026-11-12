extends Control

@onready var question_text: Label = $PanelContainer/MarginContainer/VBoxContainer/question_text
@onready var options_container: GridContainer = $PanelContainer/MarginContainer/VBoxContainer/options_container
@onready var next_button = $"PanelContainer/MarginContainer/VBoxContainer/Next Button"
var questions: Array[Dictionary] = [
	{
		"question": "How many years has it been\nsince UCF's founding?",
		"options": [63, 67, 70, 69],
		"answerIdx": 0
	}, 
	{
		"question": "How many general parking garages\nare there?",
		"options": [8,10,9,6],
		"answerIdx": 3
	}, 
	{
		"question": "This is the question",
		"options": ["Option1", "Option2", "Option3", "Option4"],
		"answerIdx": 1
	}
]
const GRADES = ["A", "B", "C", "F"]
var currentGradeIdx = 0
var optionsIdx: Array[int] = [0,1,2,3] #helper array to randomize option order


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_button.visible = false;
	randomize() #sets the seed
	
	questions.shuffle()
	question_text.text = questions[0]["question"]
	
	var buttons = options_container.get_children()
	
	optionsIdx.shuffle() 
	
	for i in range(buttons.size()):
		var button = buttons[i]
		
		var choice_idx = optionsIdx[i]
		
		var button_label = button.get_node("Label")
		button_label.text = str(questions[0]["options"][choice_idx])
		button.pressed.connect(_on_button_pressed.bind(choice_idx))

func _process(delta: float) -> void:
	if($Timer.time_left > 0) :
		$TimerLabel.text = str(ceili($Timer.time_left))
		var timePercentage = (1- $Timer.get_time_left() / $Timer.get_wait_time()) * 100
		$TimerBar.value = timePercentage
	elif($Timer.time_left == 0 || $Timer.is_stopped()):
		options_container.visible = false
		$TimerLabel.visible = false
		$TimerBar.visible = false
		next_button.visible = true
		

func _on_button_pressed(choice_idx: int) -> void:
	if(choice_idx == questions[0]["answerIdx"]):
		question_text.text = "Correct!\n\nGrade:" + GRADES[currentGradeIdx]
		
	else:
		currentGradeIdx+=1
		question_text.text = "Incorrect! \n\nGrade dropped to: " + GRADES[currentGradeIdx]
	$Timer.stop()
	


func _on_timer_timeout() -> void:
	currentGradeIdx+=1
	question_text.text = "Timeout! \n\nGrade dropped to: " + GRADES[currentGradeIdx]


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
