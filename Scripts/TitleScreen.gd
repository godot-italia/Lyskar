extends Control

onready var ts_color_rect : ColorRect = $CanvasLayer/ColorRect
onready var ts_animations : AnimationPlayer = $CanvasLayer/animations
onready var ts_commands : VBoxContainer = $Commands/VBoxContainer
onready var ts_canvas_com : CanvasLayer = $Commands
onready var c_hover_node : Sprite = $Commands/c_hover
onready var ts_bgm : AudioStreamPlayer = $bgm
onready var ts_sfx : AudioStreamPlayer = $sfx
onready var c_tween : Tween = $Commands/c_hover/tween
var c_move_sfx : Resource = preload("res://Assets/Sounds/SFX/switch15.wav")
var ts_is_active : bool = false
var buttons : Array = []
var cursor_scene : PackedScene = preload("res://Scenes/Cursor.tscn")
var cursor : Node = cursor_scene.instance()
var index : int = 0

func _ready():
	ts_bgm.play()
	ts_color_rect.color = Color(0,0,0,1)
	ts_animations.play("fade_in")
	for node in ts_commands.get_children():
		if node is Button:
			node.connect("mouse_entered",self,"set_cursor",[node.get_index()])
			node.connect("button_up",self,"execute_command",[node.get_index()])
			buttons.append(node)

func _on_animations_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_in":
		create_cursor()
	pass # Replace with function body.


func create_cursor() -> void:
	c_hover_node.visible = true
	c_tween.interpolate_property(c_hover_node, "modulate", Color(0,0,0,0),
	Color(1,1,1,1),0.2,Tween.TRANS_CUBIC,Tween.EASE_IN)
	c_tween.start()
	cursor.rect_global_position = Vector2(-40,315)
	ts_canvas_com.add_child(cursor)
	cursor.tween.interpolate_property(cursor, "modulate", Color(0,0,0,0),
	Color(1,1,1,1),0.2,Tween.TRANS_CUBIC,Tween.EASE_IN)
	cursor.tween.start()
	yield(cursor.tween,"tween_completed")
	ts_is_active = true
	set_cursor(0)

func set_cursor(new_index : int) -> void:
	if ts_is_active:
		if new_index >= 0 and new_index < len(buttons):
			if new_index != index:
				ts_sfx.stream = c_move_sfx
				ts_sfx.stream.set("loop",false)
				ts_sfx.play()
			index = new_index
			var selected_command = buttons[index]
			selected_command.grab_focus()
			var c_new_position = Vector2(
				selected_command.rect_global_position.x - 25,
				selected_command.rect_global_position.y + 25
			)
			var ch_new_position = Vector2(
				selected_command.rect_global_position.x + 160,
				selected_command.rect_global_position.y + 28
			)
			c_tween.interpolate_property(c_hover_node,
			"global_position",c_hover_node.get_global_position(),
			ch_new_position,0.1,Tween.TRANS_LINEAR,Tween.EASE_IN)
			c_tween.start()
			cursor.tween.interpolate_property(cursor, "rect_global_position",
			cursor.get_global_position(),c_new_position,0.1,
			Tween.TRANS_LINEAR,Tween.EASE_IN)
			cursor.tween.start()

func execute_command(index : int) -> void:
	var selected_button = buttons[index]
	if selected_button.has_method("start_action"):
		selected_button.start_action()

func _process(delta):
	if ts_is_active:
		if Input.is_action_just_pressed("ui_up"):
			set_cursor(index - 1)
		if Input.is_action_just_pressed("ui_down"):
			set_cursor(index + 1)
