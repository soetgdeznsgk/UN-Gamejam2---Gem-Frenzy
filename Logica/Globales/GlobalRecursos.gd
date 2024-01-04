extends Node

# Singleton para manejar el dinero y los minerales actuales

# inicia en ceros
var minerales : Array = [0,0,0,0,0,0,0,0,0,0,0]
var dinero : int = 500
signal cambioDinero(dinero)
signal cambioMineral(mineral, cantidad)
signal bancarota
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

func pagueme_la_renta():
	var dia = GlobalTiempo.diaActual 
	var valorDia = 3*GlobalTiempo.diaActual
	
	if dia > 3:
		valorDia = 4 * GlobalTiempo.diaActual - 2
	
	if dia > 6:
		valorDia = 6 * GlobalTiempo.diaActual - 4
	
	if dia > 8:
		valorDia = 7 * GlobalTiempo.diaActual
	
	if GlobalTiempo.diaActual == 1:
		valorDia = 3
	if valorDia > 60:
		valorDia = 60
	
	print("valor renta: ", valorDia)
	actualizar_dinero( -valorDia )
	
	var reciclar : int = 0
	for i in range(len(minerales)):
		var mitad = int(3*minerales[i]/4)
		actualizar_mineral(i, -mitad)
		reciclar += (mitad * (i/2 + 1))
	
	var oro = int(reciclar * 0.04)
	actualizar_dinero(oro)
