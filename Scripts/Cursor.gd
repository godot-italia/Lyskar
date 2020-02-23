extends Control

onready var gfx : Sprite = $gfx
onready var animations : AnimationPlayer = $animations
onready var tween : Tween = $tween

func _ready():
	animations.play("idle")
	tween.interpolate_property(gfx, "modulate", Color(0,0,0,0), 
		Color(1,1,1,1), 0.2, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()
