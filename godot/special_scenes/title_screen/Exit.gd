extends Button

onready var ts_animations : AnimationPlayer = get_parent().get_parent().get_parent().get_child(1).get_child(0)
onready var ts_node : Control = get_parent().get_parent().get_parent()
onready var ts_bgm : AudioStreamPlayer = get_parent().get_parent().get_parent().get_child(3)
onready var tween_bgm : AudioStreamPlayer = get_parent().get_parent().get_parent().get_child(3).get_child(0)

func start_action() -> void:
	ts_node.ts_is_active = false
	ts_animations.play("fade_out")
	tween_bgm.interpolate_property(ts_bgm,"volume_db",ts_bgm.get_volume_db(),-80,1.0,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween_bgm.start()
	yield(ts_animations,"animation_finished")
	get_tree().quit()
