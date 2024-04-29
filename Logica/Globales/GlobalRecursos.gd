extends Node

# Singleton para manejar el dinero y los minerales actuales

# inicia en ceros
const cantidadTiposMinerales = 11
var minerales : Array = []
var dinero : int = 500
signal cambioDinero(dinero)
signal cambioMineral(mineral, cantidad)
signal bancarota
var valorDia
signal rentadia

var Ahorro
var Gananciadia
var Gananciabono
var GananciaReciclaje
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
	reiniciar_minerales()
	GlobalTiempo.iniciarDia.connect(actualizar_renta)
	GlobalTiempo.finalizarDia.connect(pagueme_la_renta)

func reiniciar_minerales():
	minerales = []
	for i in range(0,cantidadTiposMinerales):
		minerales.append(0)

func actualizar_mineral(mineral : int, cantidad : int):
	minerales[mineral] += cantidad
	cambioMineral.emit(mineral, minerales[mineral])

func actualizar_dinero(cantidad : int):
	if cantidad != 0:
		dinero += cantidad
		cambioDinero.emit(dinero)
		if dinero < 0:
			bancarota.emit()

func reiniciar_factura():
	Gananciadia=0
	Gananciabono=0
	GananciaReciclaje=0

func actualizar_renta():
	Ahorro=dinero
	reiniciar_factura()
	var dia = GlobalTiempo.diaActual 
	valorDia = 2*GlobalTiempo.diaActual
	
	if dia >= 3 and dia < 5:
		valorDia = 3 * GlobalTiempo.diaActual
	
	if dia >= 5 and dia <=6:
		valorDia = int(3.5 * GlobalTiempo.diaActual)
	
	if dia >= 7 and dia <9:
		valorDia = int(4.85 * GlobalTiempo.diaActual) - 3
	
	if dia >= 9:
		#funcion= 1.5 (x-2)^(2)
		valorDia = int(1.5*pow(GlobalTiempo.diaActual-2,2))
		
	if GlobalTiempo.diaActual == 1:
		valorDia = 3
	
	rentadia.emit()

func pagueme_la_renta():
	var reciclar : int = 0
	var totalreciclado: int = 0
	if GlobalTiempo.diaActual < 2:
		for i in range(len(minerales)):
			var mitad = int(3*minerales[i]/4)
			actualizar_mineral(i, -mitad)
			@warning_ignore("integer_division")
			reciclar += (mitad * (i/2))
		
		totalreciclado = int(reciclar * 0.035)
	
	if GlobalTiempo.diaActual >= 3:
		for i in range(len(minerales)):
			var mitad = int(3*minerales[i]/4)
			actualizar_mineral(i, -mitad)
			@warning_ignore("integer_division")
			reciclar += (mitad * (i+1/2))
		
		totalreciclado = int(reciclar * 0.036)
	
	GlobalRecursos.GananciaReciclaje=totalreciclado
	actualizar_dinero(totalreciclado)
	# luego de obtener oro por minerales de sobra, se cobra la renta
	actualizar_dinero( -valorDia )
	
	
