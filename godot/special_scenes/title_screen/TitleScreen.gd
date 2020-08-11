extends Control

#================================================================
# Title_Screen Script
#================================================================

#================================================================
# Start Script Variable
#================================================================

#Onready Variable
onready var ts_title_screen_bg : Sprite = $CanvasLayer/Sprite
onready var ts_commands_container : VBoxContainer = $CanvasLayer/VBoxContainer
onready var ts_root : CanvasLayer = $CanvasLayer
onready var ts_animation_player : AnimationPlayer = $AnimationPlayer
onready var ts_bgm_player : AudioStreamPlayer = $Bgm
onready var ts_sfx_player : AudioStreamPlayer = $Sfx
onready var ts_bgm_tween : Tween = $Bgm/Tween

#Int Variable
var cursor_index : int = 0

#Boolean Variable
var ts_inputs_active : bool = false

#Dictionary Variable
var ts_commands_data : Dictionary = {
	"Main":{
		0:{
			"Name":"New Game",
			"Action":"_on_Game_Start"
		},
		1:{
			"Name":"Continue",
			"Action":"_on_Game_Continue"
		},
		2:{
			"Name":"Options",
			"Action":"_on_Game_Options"
		},
		3:{
			"Name":"Exit",
			"Action":"_on_Game_Exit"
		}
	}
}

#PackedScenes Variable
var ts_cursor : PackedScene = preload("res://special_scenes/ui_elements/Cursor.tscn")
var ts_hover : PackedScene = preload("res://special_scenes/ui_elements/Hover.tscn")
var ts_base_button : PackedScene = preload("res://special_scenes/title_screen/Base_Button.tscn")

#Resource Variable
var ts_bgm : AudioStream = preload("res://assets/sounds/BGM/Solomon Allen - RPG Title Screen Music Pack - 02 Forward! The Advent of Birth to Adventure Starts With You!.wav")
var ts_cursor_move : AudioStream = preload('res://assets/sounds/SFX/switch15.wav')

#================================================================
# End Script Variable
#================================================================

#================================================================
# Start Script Code
#================================================================

func _ready():
	_create_commands("Main")
	ts_animation_player.play("fade_in")
	yield(ts_animation_player,"animation_finished")
	_create_cursor(Vector2(-50,294))
	_create_hover(Vector2(0,0))
	_set_cursor(0)
	_play_bgm(ts_bgm)
	ts_inputs_active = true

func _input(event):
	if ts_inputs_active:
		if event.is_action_pressed("ui_down"):
			_set_cursor(cursor_index + 1)
		elif event.is_action_pressed("ui_up"):
			_set_cursor(cursor_index - 1)

func _create_commands(scene : String):
	for index in ts_commands_data[scene]:
		var new_button : TextureButton = ts_base_button.instance()
		var new_button_name = ts_commands_data[scene][index]["Name"]
		var new_button_action = ts_commands_data[scene][index]["Action"]
		new_button.connect("button_down", self, "_on_button_down",[new_button])
		ts_commands_container.add_child(new_button)
		new_button._setup(new_button_name, new_button_action)

func _create_cursor(initial_position : Vector2):
	var new_cursor = ts_cursor.instance()
	ts_root.add_child(new_cursor)
	new_cursor.rect_global_position = initial_position

func _create_hover(initial_position : Vector2):
	var new_hover = ts_hover.instance()
	ts_root.add_child_below_node(ts_title_screen_bg, new_hover)
	new_hover.rect_global_position = initial_position

func _play_bgm(file_audio : AudioStream):
	ts_bgm_player.stream = file_audio
	ts_bgm_player.play()

func _play_sfx(file_audio : AudioStream):
	ts_sfx_player.stream = file_audio
	ts_sfx_player.play()

func _fade_out_bgm(seconds : float):
	ts_bgm_tween.interpolate_property(ts_bgm_player, "volume_db",
		0, -80, seconds, Tween.TRANS_LINEAR, Tween.EASE_IN)
	ts_bgm_tween.start()

func _on_button_down(button : TextureButton):
	var method : String = button.bb_command_action
	if has_method(method):
		call(method)

func _set_cursor(new_index : int):
	var cursor = get_tree().get_nodes_in_group("Cursor")[0]
	var hover = get_tree().get_nodes_in_group("Hover")[0]
	var commands_array : Array = ts_commands_container.get_children()
	if new_index in range(0,commands_array.size()):
		_play_sfx(ts_cursor_move)
		var button_selected : TextureButton = commands_array[new_index]
		cursor_index = new_index
		cursor._animate_cursor_position(button_selected.rect_global_position, Vector2(-25,30))
		hover._animate_hover_position_y(button_selected.rect_global_position.y, 0)
		button_selected.grab_focus()

func _release_buttons_focus():
	var commands_array : Array = ts_commands_container.get_children()
	for button in commands_array:
		if button.has_focus():
			button.release_focus()

func _on_Game_Start():
	#fai cose
	pass

func _on_Game_Continue():
	#fai cose
	pass

func _on_Game_Options():
	#fai cose
	pass

func _on_Game_Exit():
	var cursor = get_tree().get_nodes_in_group("Cursor")[0]
	var hover = get_tree().get_nodes_in_group("Hover")[0]
	_fade_out_bgm(1.2)
	_release_buttons_focus()
	cursor._start_fade_out()
	hover._start_fade_out()
	ts_inputs_active = false
	ts_animation_player.play("fade_out")
	yield(ts_animation_player, "animation_finished")
	get_tree().quit()

#================================================================
# End Script Code
#================================================================
