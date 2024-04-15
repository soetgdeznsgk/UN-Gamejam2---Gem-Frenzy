extends Node
var sound:bool
var language:String

# Called when the node enters the scene tree for the first time.
func _ready():
	language= OS.get_locale_language()
	#si alguien lee seto no se si es correcot help jejejjejejej
	if language!="es" and language!="en" and language !="zh" and language !="jp":
		language="en"
	sound=true
	#language="en"
