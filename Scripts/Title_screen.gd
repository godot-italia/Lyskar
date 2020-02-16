extends Control

onready var ts_color_rect : ColorRect = $CanvasLayer/ColorRect
onready var ts_animations : AnimationPlayer = $CanvasLayer/animations
onready var ts_commands : VBoxContainer = $Commands/VBoxContainer
onready var ts_canvas_com : CanvasLayer = $Commands
onready var c_hover_node : Sprite = $Commands/c_hover
onready var ts_bgm : AudioStreamPlayer = $bgm
onready var ts_sfx : AudioStreamPlayer = $sfx
onready var c_tween : Tween = $Commands/c_hover/tween
var c_move_sfx : Resource = preload("res://SFX/cursor_move.ogg")
var ts_is_active : bool = false
var buttons : Array = []
var cursor_scene = preload("res://Scenes/Cursor.tscn")
var cursor = cursor_scene.instance()
var index = 0

func _ready():
	ts_color_rect.color = Color(0,0,0,1)
	ts_animations.play("fade_in")
	for node in ts_commands.get_children():
		if node is Button:
			node.connect("mouse_entered",self,"set_cursor",[node.get_index()])
			buttons.append(node)
	pass 


func _on_animations_animation_finished(anim_name):
	if anim_name == "fade_in":
		ts_is_active = true
		create_cursor()
	pass # Replace with function body.


func create_cursor():
	c_hover_node.visible = true
	c_tween.interpolate_property(c_hover_node, "modulate", Color(0,0,0,0),
	Color(1,1,1,1),0.2,Tween.TRANS_CUBIC,Tween.EASE_IN)
	c_tween.start()
	ts_canvas_com.add_child(cursor)
	set_cursor(0)
	pass


func set_cursor(new_index : int):
	if new_index >= 0 and new_index < len(buttons):
		if new_index != index:
			ts_sfx.stream = c_move_sfx
			ts_sfx.stream.set("loop",false)
			ts_sfx.play()
		index = new_index
		var selected_command = buttons[index]
		c_hover_node.global_position = Vector2(
			selected_command.rect_global_position.x + 160,
			selected_command.rect_global_position.y + 28
		)
		cursor.rect_global_position = Vector2(
			selected_command.rect_global_position.x - 25,
			selected_command.rect_global_position.y + 25
		)
	if ts_is_active:
		if new_index >= 0 and new_index < len(buttons):
			if new_index != index:
				ts_sfx.stream = c_move_sfx
				ts_sfx.stream.set("loop",false)
				ts_sfx.play()
			index = new_index
			var selected_command = buttons[index]
			c_hover_node.global_position = Vector2(
				selected_command.rect_global_position.x + 160,
				selected_command.rect_global_position.y + 28
			)
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
