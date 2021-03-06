extends Control

#================================================================
# TS_Cursor Script
#================================================================

#================================================================
# Start Script Variable
#================================================================

#Onready Variable
onready var gfx : Sprite = $gfx
onready var animations : AnimationPlayer = $animations
onready var tween : Tween = $tween

#================================================================
# End Script Variable
#================================================================

#================================================================
# Start Script Code
#================================================================

func _ready():
	_play_idle_animation()
	_start_fade_in()

func _play_idle_animation():
	animations.play("idle")

func _start_fade_in():
	tween.interpolate_property(gfx, "modulate", Color(1,1,1,0), 
		Color(1,1,1,1), 0.2, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()

func _start_fade_out():
	tween.interpolate_property(gfx, "modulate", Color(1,1,1,1), 
		Color(1,1,1,0), 0.2, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()

func _animate_cursor_position(new_position : Vector2, offset : Vector2):
	tween.interpolate_property(self, "rect_global_position", rect_global_position,
		new_position + offset, 0.15, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()

#================================================================
# End Script Code
#================================================================
