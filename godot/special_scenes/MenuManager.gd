extends Node

onready var pauseMenu : Panel = $PauseMenu/PauseMenuPanel
onready var optionsMenu : Panel = $OptionsMenu/OptionsMenuPanel
onready var audioOptions : Panel = $AudioOptions/AudioOptionsPanel
onready var graphicsOptions : Panel = $GraphicsOptions/GraphicsOptionsPanel
onready var gameOptions : Panel = $GameOptions/GameOptionsPanel

onready var resumeButton : Button = $PauseMenu/PauseMenuPanel/CenterContainer/VBoxContainer/ResumeButton
onready var optionsButton : Button = $PauseMenu/PauseMenuPanel/CenterContainer/VBoxContainer/OptionsButton

onready var audioOptionsButton : Button = $OptionsMenu/OptionsMenuPanel/CenterContainer/VBoxContainer/AudioOptionsButton
onready var graphicsOptionsButton : Button = $OptionsMenu/OptionsMenuPanel/CenterContainer/VBoxContainer/GraphicsOptionsButton
onready var gameOptionsButton : Button = $OptionsMenu/OptionsMenuPanel/CenterContainer/VBoxContainer/GameOptionsButton

onready var backFromOptionsButton : Button = $OptionsMenu/OptionsMenuPanel/CenterContainer/VBoxContainer/BackFromOptionsButton
onready var backFromAudioOptionsButton : Button = $AudioOptions/AudioOptionsPanel/CenterContainer/VBoxContainer/BackFromAudioOptionsButton
onready var backFromGraphicsOptionsButton : Button = $GraphicsOptions/GraphicsOptionsPanel/CenterContainer/VBoxContainer/BackFromGraphicsOptionsButton
onready var backFromGameOptionsButton : Button = $GameOptions/GameOptionsPanel/CenterContainer/VBoxContainer/BackFromGameOptionsButton

var indexMenu : int = 0

func _ready() -> void:
	resumeButton.connect("pressed", self, "_on_resumeButton_pressed")
	optionsButton.connect("pressed", self, "_on_optionsButton_pressed")
	audioOptionsButton.connect("pressed", self, "_on_audioOptionsButton_pressed")
	graphicsOptionsButton.connect("pressed", self, "_on_graphicsOptionsButton_pressed")
	gameOptionsButton.connect("pressed", self, "_on_gameOptionsButton_pressed")
	backFromOptionsButton.connect("pressed", self, "_on_backToLayer1Button_pressed")
	backFromAudioOptionsButton.connect("pressed", self, "_on_backToLayer2Button_pressed")
	backFromGraphicsOptionsButton.connect("pressed", self, "_on_backToLayer2Button_pressed")
	backFromGameOptionsButton.connect("pressed", self, "_on_backToLayer2Button_pressed")

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
	elif indexMenu == 3:
		audioOptions.visible = false
		graphicsOptions.visible = false
		gameOptions.visible = false
		indexMenu = 2

func _on_resumeButton_pressed():
	pauseMenu.visible = false
	indexMenu = 0

func _on_optionsButton_pressed():
	optionsMenu.visible = true
	indexMenu = 2

func _on_backToLayer1Button_pressed():
	optionsMenu.visible = false
	indexMenu = 1

func _on_backToLayer2Button_pressed():
	audioOptions.visible = false
	graphicsOptions.visible = false
	gameOptions.visible = false
	indexMenu = 2

func _on_audioOptionsButton_pressed():
	audioOptions.visible = true
	indexMenu = 3

func _on_graphicsOptionsButton_pressed():
	graphicsOptions.visible = true
	indexMenu = 3

func _on_gameOptionsButton_pressed():
	gameOptions.visible = true
	indexMenu = 3
