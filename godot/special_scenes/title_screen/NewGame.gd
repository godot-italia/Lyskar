extends Button

var main_scene : PackedScene = null

func _ready() -> void:
	main_scene = preload("res://special_scenes/MainGame.tscn")

func start_action() -> void:
	print("Main Scene")
	get_tree().change_scene_to(main_scene)
