extends Control

@onready var question_text: Label = $PanelContainer/MarginContainer/VBoxContainer/question_text
@onready var options_container: GridContainer = $PanelContainer/MarginContainer/VBoxContainer/options_container

var choices: Array[String] = ["Option1", "Option2", "Option3", "Option4"]
var optionsIdx: Array[int] = [0,1,2,3] #helper array to randomize option order
var correctChoice: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	question_text.text = "This is the question"
	
	var buttons = options_container.get_children()
	
	randomize() #sets the seed
	optionsIdx.shuffle() 
	
	for i in range(buttons.size()):
		var button = buttons[i]
		
		var choice_idx = optionsIdx[i]
		
		var button_label = button.get_node("Label")
		button_label.text = choices[choice_idx]
		button.pressed.connect(_on_button_pressed.bind(choice_idx))

func _on_button_pressed(choice_idx: int) -> void:
	if(choice_idx == correctChoice):
		question_text.text = "Correct!"
	else:
		question_text.text = "incorrect"
	options_container.visible = false
