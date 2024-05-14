extends Node
var sound:bool
var language:String
@warning_ignore("unused_signal")
signal sound_changed
var fullscreen
# Called when the node enters the scene tree for the first time.
func _ready():
	fullscreen=false
	language= OS.get_locale_language()
	#si alguien lee seto no se si es correcot help jejejjejejej
	if language!="es" and language!="en" and language !="zh" and language !="jp":
		language="en"
	sound=true
	#language="en"
