extends Label
var strTiempo : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTiempo.iniciarDia.connect(actualizarDia)

func actualizarDia():
	text = 'Dia: ' + str(GlobalTiempo.diaActual)
