extends Node
class_name Base_Actor

var sprite : Sprite = Sprite.new()

func add_component(component : Node) -> void:
	add_child(component)

func remove_component(component : Node) -> void:
	remove_child(component)
