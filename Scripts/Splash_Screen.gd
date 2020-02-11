extends Control

onready var sc_sprite : Sprite = $image
onready var sc_animations : AnimationPlayer = $animations
onready var sc_timer : Timer = $time
var ts_scene = "res://Scenes/Title_screen.tscn"

func _ready():
	sc_sprite.modulate = Color(0,0,0,1)
	sc_animations.play("fade_in")
	pass 


func _on_time_timeout():
	sc_animations.play("fade_out")
	pass


func _on_animations_animation_finished(anim_name):
	if anim_name == "fade_in":
		sc_timer.start()
	if anim_name == "fade_out":
		get_tree().change_scene(ts_scene)
	pass
