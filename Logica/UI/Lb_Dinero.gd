extends Label
@onready var Lb_dinero = %Lb_Dinero
var strDinero : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalRecursos.cambioDinero.connect(actualizarDinero)

func actualizarDinero(dinero):
	if dinero < 10:
		strDinero = '00' + str(dinero)
	elif dinero < 100 and dinero > 10:
		strDinero = '0' + str(dinero)
	else:
		strDinero = str(dinero)
	Lb_dinero.text = strDinero 
	#todo animacion de moneda en la ui girando

func actualizarMinerales(mineral, cantidad):
	pass
