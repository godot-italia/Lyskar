tool
extends Reference
class_name VNEngine

const filepaths : String = "res://res/VisualNovelEngine/example/files/"
const file_extension : String = ".dg"
const file_delimiter : String = ";"

"""
the 'Dialog' class is used to store a single dialog inside a file.
While a file could represent a 'chapter' of the story or a piece of of it, a dialog stores a sequence of speakers
that interact with the player. 
Each dialog is a Dictionary represented by 3 main parts: the 'who', the 'where' and the 'what'.
Each line of dialog is a single element of the array contained in the 'what'
"""
class Dialog :
    # Contains all dialogs
    var current_dialogs : Array = []
    # Index for a dialog
    var current_dialog_index : int = 0
    # Index for a line in a dialog
    var current_line_index : int = 0

    # Constructor for Dialog class
    func _init(dialog : Array):
        current_dialogs = dialog

    # Get a single dialog
    func get_dialog(index : int = 0) -> Dictionary:
        current_dialog_index = index
        return current_dialogs[current_dialog_index]

    # Get the next dialog
    func get_next_dialog() -> Dictionary:
        if current_dialog_index < current_dialogs.size()-1:
            current_dialog_index+=1
            return get_dialog(current_dialog_index)
        return {}

    # Get the previous dialog
    func get_previous_dialog() -> Dictionary:
        if current_dialog_index > 0:
            current_dialog_index-=1
            return get_dialog(current_dialog_index)
        return {}

    # Get the speaker of the current dialog (who.name)
    func get_speaker() -> String:
        return current_dialogs[current_dialog_index].who.name

    # Get the place and time of the current dialog (where.place and where.time)
    func get_where() -> String:
        return "%s_%s" % [current_dialogs[current_dialog_index].where.place, current_dialogs[current_dialog_index].where.time]

    func get_line(line_index : int = 0) -> DialogLine:
        current_line_index = line_index
        return DialogLine.new(get_dialog(current_dialog_index).what[current_line_index])

    # Get the next line of a dialog
    func get_next_line() -> DialogLine:
        if current_line_index < get_dialog(current_dialog_index).what.size()-1:
            current_line_index+=1
            return get_line(current_line_index)
        return null

    # Get the next line of a dialog
    func get_previous_line() -> DialogLine:
        if current_line_index > 0:
            current_line_index-=1
            return get_line(current_line_index)
        return null

"""
A single line of dialog, contained in a Dictionary with some additional parameters:
    @type : the type of dialog, can be 'say','ask','answer'
    @expression : expression of the speaker within this line of dialog
    @text : the text spoken by the speaker
    @options : an array containing all available options. Only present with a type 'ask'
    -- additional parameters, identified by numbers, only present with a 'answer' type line of dialog, and each index respects the 'options' indexes
"""
class DialogLine:
    enum Types { SAY, ASK, ANSWER }
    # the current line of dialog
    var current_dialog_line : Dictionary = {}

    func _init(dialog_line : Dictionary):
        current_dialog_line = dialog_line

    func get_type() -> int:
        return current_dialog_line.type

    func get_expression() -> String:
        return current_dialog_line.expression

    func get_text() -> String:
        return current_dialog_line.text

    func get_options() -> Array:
        return current_dialog_line.options

    func get_answer(answer_index : int) -> DialogLine:
        return DialogLine.new(current_dialog_line.get(str(answer_index)))


# Called when the node enters the scene tree for the first time.
func _ready():
    pass

func load_dialog(_filename : String) -> Dialog:
    var file : File = File.new()
    file.open(filepaths+_filename+file_extension, File.READ)
    var dialogs : Array = JSON.parse(file.get_as_text()).result.dialogs
    file.close()
    return Dialog.new(dialogs)
