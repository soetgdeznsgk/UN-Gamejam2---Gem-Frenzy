extends HBoxContainer

var number : int
var playerName : String
var day : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label3.text = str(number) + str(playerName)
	$Label4.text = tr("DIA") + ": " + str(day)
