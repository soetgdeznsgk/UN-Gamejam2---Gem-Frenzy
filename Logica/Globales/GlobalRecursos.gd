extends Node

# Singleton para manejar el dinero y los minerales actuales

# inicia en ceros
var minerales : Array = [0,0,0,0,0,0,0,0,0,0,0]
var dinero : int = 90
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
	var valorDia = 2*GlobalTiempo.diaActual
	if valorDia > 17:
		valorDia = 17
	actualizar_dinero(-3 - valorDia)
	for i in range(len(minerales)):
		var oro = int(minerales[i] * 0.1)
		var mitad = int(minerales[i]/2)
		actualizar_mineral(i, -mitad)
		actualizar_dinero(oro)
