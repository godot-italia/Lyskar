extends Base_Actor

var graphics : Resource = load("res://icon.png")
var color : Color = Color(1,0,0,1)

func _ready():
	sprite.texture = graphics
	sprite.modulate = color
	add_component(sprite)
	pass
