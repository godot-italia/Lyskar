extends Control

onready var ts_color_rect : ColorRect = $CanvasLayer/ColorRect
onready var ts_animations : AnimationPlayer = $CanvasLayer/animations
onready var ts_commands : VBoxContainer = $Commands/VBoxContainer
onready var ts_canvas_com : CanvasLayer = $Commands
var ts_is_active : bool = false
var labels : Array = []
var cursor_scene = preload("res://Scenes/Cursor.tscn")
var cursor = cursor_scene.instance()
var index = 0

func _ready():
	ts_color_rect.color = Color(0,0,0,1)
	ts_animations.play("fade_in")
	for node in ts_commands.get_children():
		if node is Label:
			labels.append(node)
	pass 


func _on_animations_animation_finished(anim_name):
	if anim_name == "fade_in":
		ts_is_active = true
		create_cursor()
	pass # Replace with function body.


func create_cursor():
	ts_canvas_com.add_child(cursor)
	set_cursor(0)
	pass


func set_cursor(new_index : int):
	if new_index >= 0 and new_index < len(labels):
		index = new_index
		var selected_command = labels[index]
		cursor.rect_global_position = Vector2(
			selected_command.rect_global_position.x - 25,
			selected_command.rect_global_position.y + 25
		)
	pass

func _process(delta):
	if ts_is_active:
		if Input.is_action_just_pressed("ui_up"):
			set_cursor(index - 1)
		if Input.is_action_just_pressed("ui_down"):
			set_cursor(index + 1)
	pass
