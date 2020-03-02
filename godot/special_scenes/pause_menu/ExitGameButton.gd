extends Button

func _ready() -> void:
	connect("pressed", self, "_on_exitGameButton_pressed")

func _on_exitGameButton_pressed():
	get_tree().quit()
