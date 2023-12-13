extends Label
@onready var Lb_dinero = %Lb_Dinero
var strDinero : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalRecursos.cambioDinero.connect(actualizarDinero)

func actualizarDinero(dinero):
	if dinero < 10 and dinero >= 0:
		strDinero = '00' + str(dinero)
	elif dinero < 100 and dinero > 10:
		strDinero = '0' + str(dinero)
	elif dinero >= 100:
		strDinero = str(dinero)
	elif dinero < 0:
		strDinero = str(dinero)
	Lb_dinero.text = strDinero 
	#todo animacion de moneda en la ui girando
