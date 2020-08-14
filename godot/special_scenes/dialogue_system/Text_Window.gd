extends Control

onready var rich_text : RichTextLabel = $RichTextLabel
onready var name_label : Label = $Label

var dialogue_folder : String = "res://assets/dialogue/"
var message_finished : bool = false
var message_id : int = 0
var timer : float
var text_delay : float = 0.05
var max_char : int = 180

var actual_dialogue : Array

func _ready():
	timer = 0
	rich_text.visible_characters = 0
	_start_dialogue("Dialogue_1")

func _input(event):
	if !message_finished:
		if event.is_action_pressed("ui_accept"):
			_skip_text()
	else:
		if event.is_action_pressed("ui_accept"):
			_next_message(message_id + 1)

func _load_dialogue(file : String):
	var dialogue_file = File.new()
	dialogue_file.open(dialogue_folder + file + ".json", File.READ)
	var data = parse_json(dialogue_file.get_as_text())
	dialogue_file.close()
	return data

func _start_dialogue(file_name : String):
	var dialogue : Array = _load_dialogue(file_name)
	var cha_name : String = dialogue[message_id]["Name"]
	var text : String = dialogue[message_id]["Message"]
	actual_dialogue = dialogue
	_set_message(cha_name, text)
	message_id = 0

func _set_message(char_name : String, text : String):
	message_finished = false
	rich_text.visible_characters = 0
	rich_text.text = text
	name_label.text = char_name

func _skip_text():
	var scroll : VScrollBar = rich_text.get_v_scroll()
	scroll.value = scroll.max_value
	rich_text.visible_characters = rich_text.text.length()
	message_finished = true

func _next_message(id : int):
	if id in range(0,actual_dialogue.size()):
		var next_name : String = actual_dialogue[id]["Name"]
		var next_text : String = actual_dialogue[id]["Message"]
		message_id = id
		_set_message(next_name, next_text)

func _process(delta):
	if rich_text.visible_characters == rich_text.text.length():
		message_finished = true
	if !message_finished:
		timer += delta
		if rich_text.get_visible_line_count() > 4:
			var last_text : String = rich_text.text.right(rich_text.visible_characters - 1)
			_set_message(actual_dialogue[message_id]["Name"], last_text)
		if timer >= text_delay:
			timer -= text_delay
			rich_text.visible_characters += 1
	else:
		timer = 0
