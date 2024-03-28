extends Node

# Singleton para manejar el dinero y los minerales actuales

# inicia en ceros
var minerales : Array = [0,0,0,0,0,0,0,0,0,0,0]
var dinero : int = 5
signal cambioDinero(dinero)
signal cambioMineral(mineral, cantidad)
signal bancarota
var valorDia
signal rentadia
# enum para no perderlos de vista

enum mineralesSinFondo{
	Hierro,
	Plata,
	Oro,
	Carbon,
	Cobre,
	Amatista,
	Topacio,
	Rubi,
	Zafiro,
	Diamante,
	Esmeralda,
}

enum mineralesConFondo{
	Hierro,
	Plata,
	Oro,
	Carbon,
	Cobre,
	Amatista,
	Topacio,
	Rubi,
	Zafiro,
	Diamante,
	Esmeralda,
	Tierra,
	TierraMinada,
}

func _ready() -> void:
	GlobalTiempo.iniciarDia.connect(actualizar_renta)
	GlobalTiempo.finalizarDia.connect(pagueme_la_renta)


func actualizar_mineral(mineral : int, cantidad : int):
	minerales[mineral] += cantidad
	cambioMineral.emit(mineral, minerales[mineral])

func actualizar_dinero(cantidad : int):
	if cantidad != 0:
		dinero += cantidad
		cambioDinero.emit(dinero)
		if dinero < 0:
			bancarota.emit()
func actualizar_renta():
	var dia = GlobalTiempo.diaActual 
	valorDia = 3*GlobalTiempo.diaActual
	
	if dia >= 3 and dia < 5:
		valorDia = 3 * GlobalTiempo.diaActual + 2
	
	if dia >= 5 and dia <6:
		valorDia = 4 * GlobalTiempo.diaActual
	
	if dia >= 7 and dia <9:
		valorDia = 5 * GlobalTiempo.diaActual - 5
	
	if dia >= 9:
		valorDia = 6 * GlobalTiempo.diaActual - 2
	
	if GlobalTiempo.diaActual == 1:
		valorDia = 3
	if valorDia > 70:
		valorDia = 70
	rentadia.emit()
	print("valor renta: ", valorDia)
func pagueme_la_renta():

	# TODO hacer q esto se vea mejor  ymas intuitivo en la ui. una animacion oalgo
	var reciclar : int = 0
	for i in range(len(minerales)):
		var mitad = int(3*minerales[i]/4)
		actualizar_mineral(i, -mitad)
		@warning_ignore("integer_division")
		reciclar += (mitad * (i/2 + 1))
	
	var oro = int(reciclar * 0.04)
	actualizar_dinero(oro)
	# luego de obtener oro por minerales de sobra, se cobra la renta
	actualizar_dinero( -valorDia )
	
	
