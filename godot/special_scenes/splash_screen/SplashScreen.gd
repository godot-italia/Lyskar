extends Control

#==============================================================
# Splash_Screen Script
#==============================================================

#==============================================================
# Start Script Variable
#==============================================================

#OnReady variable
onready var sc_sprite : Sprite = $CanvasLayer/image
onready var sc_animations : AnimationPlayer = $CanvasLayer/animations
onready var sc_timer : Timer = $CanvasLayer/time

#Boolean variable
var can_skip : bool = false

#String variable
var ts_scene : String = "res://special_scenes/title_screen/TitleScreen.tscn"

#==============================================================
# End Script Variable
#==============================================================

#==============================================================
# Start Script Code
#==============================================================

func _ready():
	_fade_in_screen()

func _input(event):
	if event.is_action_pressed("ui_accept") and can_skip:
		if !sc_timer.is_stopped():
			sc_timer.stop()
			_fade_out_screen()
			can_skip = false

func _fade_out_screen() -> void:
	sc_animations.play("fade_out")

func _fade_in_screen() -> void:
	sc_animations.play("fade_in")

#==============================================================
# Start Script Signals
#==============================================================

func _on_time_timeout():
	_fade_out_screen()
	can_skip = false

func _on_animations_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_in":
		sc_timer.start()
		can_skip = true
	if anim_name == "fade_out":
		get_tree().change_scene(ts_scene)

#==============================================================
# End Script Signals
#==============================================================

#==============================================================
# End Start Script Code
#==============================================================
