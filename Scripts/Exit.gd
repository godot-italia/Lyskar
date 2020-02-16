extends Button

onready var ts_animations : AnimationPlayer = get_parent().get_parent().get_parent().get_child(1).get_child(0)
onready var ts_node : Control = get_parent().get_parent().get_parent()

func start_action():
	ts_node.ts_is_active = false
	ts_animations.play("fade_out")
	yield(ts_animations,"animation_finished")
	get_tree().quit()
	pass
