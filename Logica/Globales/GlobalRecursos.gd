extends Node

# Singleton para manejar el dinero y los minerales actuales

# inicia en ceros
var minerales : Array = [0,0,0,0,0,0,0,0,0]
var dinero : int = 0

signal cambioDinero(dinero)
signal cambioMineral(mineral, cantidad)
# enum para no perderlos de vista
enum {
	Hierro,
	Plata,
	Oro,
	Carbon,
	Cobre,
	Amatista,
	Esmeralda,
	Topacio,
	Rubi,
	Zafiro,
	Diamante
}

func actualizar_mineral(mineral : int, cantidad : int):
	minerales[mineral] += cantidad
	cambioMineral.emit(mineral, minerales[mineral])

func actualizar_dinero(cantidad : int):
	dinero += cantidad
	cambioDinero.emit(dinero)
	if dinero < 0:
		#todo gameover por bancarota
		pass
