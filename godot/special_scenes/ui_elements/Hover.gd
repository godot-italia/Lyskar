extends Control

#================================================================
# TS_Hover Script
#================================================================

#================================================================
# Start Script Variable
#================================================================

#Onready Variable
onready var hover_tween : Tween = $Tween

#================================================================
# End Script Variable
#================================================================

#================================================================
# Start Script Code
#================================================================

func _ready():
	_start_fade_in()

func _start_fade_in():
	hover_tween.interpolate_property(self, "modulate", Color(1,1,1,0), 
		Color(1,1,1,1), 0.2, Tween.TRANS_CUBIC, Tween.EASE_IN)
	hover_tween.start()

func _start_fade_out():
	hover_tween.interpolate_property(self, "modulate", Color(1,1,1,1), 
		Color(1,1,1,0), 0.2, Tween.TRANS_CUBIC, Tween.EASE_IN)
	hover_tween.start()

func _animate_hover_position_y(y : float, offset_y : float = 0):
	hover_tween.interpolate_property(self, "rect_global_position:y", rect_global_position.y,
		y + offset_y, 0.15, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	hover_tween.start()

#================================================================
# End Script Code
#================================================================
