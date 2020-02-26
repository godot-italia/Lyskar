extends Control

onready var sc_sprite : Sprite = $image
onready var sc_animations : AnimationPlayer = $animations
onready var sc_timer : Timer = $time
var can_skip : bool = false
var ts_scene : String = "res://godot/special_scenes/title_screen/TitleScreen.tscn"

func _ready():
	sc_sprite.modulate = Color(0,0,0,1)
	fade_in_screen()
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_accept") and can_skip:
		if sc_timer.time_left < sc_timer.wait_time:
			sc_timer.stop()
			fade_out_screen()
			can_skip = false

func _on_time_timeout():
	fade_out_screen()
	can_skip = false

func fade_out_screen() -> void:
	sc_animations.play("fade_out")

func fade_in_screen() -> void:
	sc_animations.play("fade_in")

func _on_animations_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_in":
		sc_timer.start()
		can_skip = true
	if anim_name == "fade_out":
		get_tree().change_scene(ts_scene)
