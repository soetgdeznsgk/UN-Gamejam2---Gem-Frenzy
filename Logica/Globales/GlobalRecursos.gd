extends Node

# Singleton para manejar el dinero y los minerales actuales

# inicia en ceros
var minerales_cofre : Array = [0,0,0,0,0,0,0,0,0,0,0]
var dinero : int = 0
var minerales_pj : Array = [0,0,0,0,0,0,0,0,0,0,0]
signal cambioDinero(dinero)
signal cambioMineralPj(mineral, cantidad)
# enum para no perderlos de vista

enum mineralesSinFondo{
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
	Diamante,
}

enum mineralesConFondo{
	Hierro,
	Plata,
	Oro,
	Carbon,
	Cobre,
	Amatista,
	Tierra,
	TierraMinada,
	Topacio,
	Rubi,
	Zafiro,
	Diamante,
	Esmeralda
}

func actualizar_mineral_cofre(mineral : int, cantidad : int):
	minerales_cofre[mineral] += cantidad
	#cambioMineral.emit(mineral, minerales_cofre[mineral])

func actualizar_mineral_pj(mineral : int, cantidad : int):
	minerales_pj[mineral] += cantidad
	cambioMineralPj.emit(mineral, minerales_pj[mineral])

func actualizar_dinero(cantidad : int):
	dinero += cantidad
	cambioDinero.emit(dinero)
	if dinero < 0:
		#todo gameover por bancarota
		pass
