extends Node

onready var pauseMenu : Panel = $PauseMenu/PauseMenuPanel
onready var optionsMenu : Panel = $OptionsMenu/OptionsMenuPanel

onready var resumeButton : Button = $PauseMenu/PauseMenuPanel/CenterContainer/VBoxContainer/ResumeButton
onready var optionsButton : Button = $PauseMenu/PauseMenuPanel/CenterContainer/VBoxContainer/OptionsButton
onready var backButton : Button = $OptionsMenu/OptionsMenuPanel/CenterContainer/VBoxContainer/BackButton

var indexMenu : int = 0

func _ready() -> void:
	resumeButton.connect("pressed", self, "_on_resumeButton_pressed")
	optionsButton.connect("pressed", self, "_on_optionsButton_pressed")
	backButton.connect("pressed", self, "_on_backButton_pressed")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		menu_visibility()

func menu_visibility():
	if indexMenu == 0:
		pauseMenu.visible = true
		indexMenu = 1
	elif indexMenu == 1:
		pauseMenu.visible = false
		indexMenu = 0
	elif indexMenu == 2:
		optionsMenu.visible = false
		indexMenu = 1

func _on_resumeButton_pressed():
	pauseMenu.visible = false
	indexMenu = 0

func _on_optionsButton_pressed():
	optionsMenu.visible = true
	indexMenu = 2

func _on_backButton_pressed():
	optionsMenu.visible = false
	indexMenu = 1
