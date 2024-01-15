extends HBoxContainer

var number : int
var playerName : String
var day : int
# Called when the node enters the scene tree for the first time.
func set_text() -> void:
	$Label.text =  str(number) +"."
	$Label3.text =str(playerName)
	$Label4.text = tr("DIA") + " " + str(day)
