extends Control

onready var _Text : RichTextLabel = $Dialog/Text
onready var _Name : Label = $Dialog/Name
onready var _Place : TextureRect = $Place
onready var _Sprite : TextureRect = $Sprite
onready var _Options : VBoxContainer = $Options
onready var _Animator : AnimationPlayer = $AnimationPlayer
onready var _Audio : AudioStreamPlayer2D = $AudioStreamPlayer2D

var _dialog : VNEngine.Dialog
var _line : VNEngine.DialogLine
var _answer : int
var is_animating : bool = false

func _initialize_reader():
    _Animator.connect("animation_started", self, "_on_animation_started")
    _Animator.connect("animation_finished", self, "_on_animation_finished")

# Called when the node enters the scene tree for the first time.
func _ready():
    _initialize_reader()
    
    var interprete : VNEngine = VNEngine.new()
    var dialog : VNEngine.Dialog = interprete.load_dialog("dialog_example_0")
    show_dialog(dialog)

func show_dialog(dialog : VNEngine.Dialog):
    _dialog = dialog
    _Name.set_text(_dialog.get_speaker())
    _Place.set_texture(load("res://res/VisualNovelEngine/example/places/"+_dialog.get_where()+".jpg"))
    var first_line : VNEngine.DialogLine = _dialog.get_line()
    match_line(first_line)

func show_next_line():
    var next_line : VNEngine.DialogLine = _dialog.get_next_line()
    if next_line!=null:
        match_line(next_line)

func show_previous_line():
    var previous_line : VNEngine.DialogLine = _dialog.get_previous_line()
    if previous_line!=null:
        match_line(previous_line)

func match_line(line : VNEngine.DialogLine):
    if line.get_type() == VNEngine.DialogLine.Types.SAY:
        hide_options()
        show_line(line)
    elif line.get_type() == VNEngine.DialogLine.Types.ANSWER:
        hide_options()
        show_line(line.get_answer(_answer))
    elif line.get_type() == VNEngine.DialogLine.Types.ASK:
        show_line(line)
        show_options(line.get_options())
    elif line.get_type() == VNEngine.DialogLine.Types.ACTION:
        hide_options()
        show_line(line)
    animate(line.get_action())

func animate(animation : String):
    _Animator.play(animation)

func show_line(line : VNEngine.DialogLine):
    _line = line
    _Text.clear()
    _Text.add_text(line.get_text())
    _Sprite.texture = load("res://res/VisualNovelEngine/example/%s/%s.png" % [_dialog.get_speaker(),line.get_expression()])

func show_options(line_options : Array):
    for option in line_options:
        var option_button : Button = Button.new()
        _Options.add_child(option_button)
        option_button.text = option
        option_button.name = str(line_options.find(option))
        option_button.connect("pressed", self, "select_answer", [option_button])
    _Options.show()

func hide_options():
    var options = _Options.get_children()
    if options:
        for option in options:
            option.queue_free()
    _Options.hide()

func select_answer(option_button : Button):
    print("Selected answer: %s (index %s)"%[option_button.text, option_button.name])
    _answer = int(option_button.name)
    show_next_line()

func _on_animation_finished(animation_name : String):
    is_animating = false

func _on_animation_started(animation_name : String):
    is_animating = true

func skip_animation():
    _Animator.stop()
    _Animator.seek(_Animator.current_animation_length, true)

func _input(event):
# Use this condition below only if you want to wait for the animation to end. This works just fine, but what if an animation loops?
#    if not is_animating:
    if Input.is_action_just_pressed("ui_left"):
        if _line.get_type() != VNEngine.DialogLine.Types.ANSWER:
            show_previous_line()
    if Input.is_action_just_pressed("ui_right"):
        if _line.get_type() != VNEngine.DialogLine.Types.ASK:
            show_next_line()
