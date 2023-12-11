extends Label
@onready var Lb_tiempo = %Lb_tiempo
var strTiempo : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTiempo.tiempoCambio.connect(actualizarTiempo)

func actualizarTiempo(minuto, hora):
	var strMin = ''
	if minuto<10:
		strMin = '0' + str(minuto)
	else:
		strMin = str(minuto)
	if hora < 12:
		strTiempo = str(hora) + ':' + strMin + ' AM'
	elif hora >= 13:
		strTiempo = str(hora-12) + ':' + strMin + ' PM'
	else:
		strTiempo = str(12) + ':' + strMin + ' PM'
	Lb_tiempo.text = strTiempo
