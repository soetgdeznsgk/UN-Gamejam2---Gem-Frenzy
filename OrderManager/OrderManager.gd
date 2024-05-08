extends Node

signal new_order(orden: OrderGem)
#var materiales := Array() # array de materiales 
@onready var recetas := Array()
@onready var currentOrders := Array()

@onready var tmr := Timer.new()
@onready var numRecetasPuestas:int=0
# Called when the node enters the scene tree for the first time.
func _ready():
	llenar_recetas()
	GlobalTiempo.iniciarDia.connect(llenar_recetas)
	GlobalRecursos.bancarota.connect(reiniciar_recetas)

func reiniciar_recetas():
	recetas.clear()
	recetas.append([GlobalRecursos.mineralesSinFondo.Carbon, GlobalRecursos.mineralesSinFondo.Hierro]) # acero


func entregarOrden(orden : OrderGem):
	var i = currentOrders.find(orden)
	if i != -1:
		currentOrders.pop_at(i) # toca compararlo desde el entregador de comidas
		return
	else:
		return
		

func llenar_recetas() -> void:
	if GlobalTiempo.diaActual == 1: # hay carbon y hierro
		recetas.append([GlobalRecursos.mineralesSinFondo.Carbon, GlobalRecursos.mineralesSinFondo.Hierro]) # acero
	if GlobalTiempo.diaActual >= 2: # hay cobre
		if GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.CofreMineral] >=1 and numRecetasPuestas<1:
			recetas.append([GlobalRecursos.mineralesSinFondo.Plata, GlobalRecursos.mineralesSinFondo.Cobre, GlobalRecursos.mineralesSinFondo.Hierro]) # allmetal
			numRecetasPuestas+=1
	if GlobalTiempo.diaActual >= 3: # hay cobre
		if GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.CofreMineral] >=2 and numRecetasPuestas<2:
			recetas.append([GlobalRecursos.mineralesSinFondo.Plata, GlobalRecursos.mineralesSinFondo.Cobre, GlobalRecursos.mineralesSinFondo.Hierro]) # allmetal
			numRecetasPuestas+=1
	if GlobalTiempo.diaActual >= 4:
		 # dia 3 añade oro, dia 4 añade topacio y rubi
		if GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.CofreMineral] >=3 and numRecetasPuestas<3:
			recetas.append([GlobalRecursos.mineralesSinFondo.Topacio, GlobalRecursos.mineralesSinFondo.Oro, GlobalRecursos.mineralesSinFondo.Rubi]) #fire cri
			numRecetasPuestas+=1
		
	if GlobalTiempo.diaActual >= 5: # dia 3 añade oro, dia 4 añade topacio y rubi
		if GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.CofreMineral] >=4 and numRecetasPuestas<4:
			recetas.append([GlobalRecursos.mineralesSinFondo.Topacio, GlobalRecursos.mineralesSinFondo.Oro, GlobalRecursos.mineralesSinFondo.Rubi]) #fire cri
			recetas.append([GlobalRecursos.mineralesSinFondo.Topacio, GlobalRecursos.mineralesSinFondo.Oro, GlobalRecursos.mineralesSinFondo.Rubi]) #fire cri
			numRecetasPuestas+=1
	if GlobalTiempo.diaActual >= 6: # hay amatista y zafiro
		if GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.CofreMineral] >=5 and numRecetasPuestas<5:
			recetas.append([GlobalRecursos.mineralesSinFondo.Plata, GlobalRecursos.mineralesSinFondo.Amatista, GlobalRecursos.mineralesSinFondo.Zafiro]) # frost cri
			recetas.append([GlobalRecursos.mineralesSinFondo.Plata, GlobalRecursos.mineralesSinFondo.Amatista, GlobalRecursos.mineralesSinFondo.Zafiro]) # frost cri
			numRecetasPuestas+=1
	if GlobalTiempo.diaActual >= 7: # hay esmeralda
		if GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.CofreMineral] >=6 and numRecetasPuestas<6:
			recetas.append([GlobalRecursos.mineralesSinFondo.Plata, GlobalRecursos.mineralesSinFondo.Amatista, GlobalRecursos.mineralesSinFondo.Zafiro]) # frost cri
			recetas.append([GlobalRecursos.mineralesSinFondo.Rubi, GlobalRecursos.mineralesSinFondo.Zafiro, GlobalRecursos.mineralesSinFondo.Esmeralda]) #  rgb cri
			recetas.append([GlobalRecursos.mineralesSinFondo.Rubi, GlobalRecursos.mineralesSinFondo.Zafiro, GlobalRecursos.mineralesSinFondo.Esmeralda]) #  rgb cri
			recetas.append([GlobalRecursos.mineralesSinFondo.Cobre, GlobalRecursos.mineralesSinFondo.Topacio, GlobalRecursos.mineralesSinFondo.Esmeralda]) #  verde
			numRecetasPuestas+=1
	if GlobalTiempo.diaActual >= 8: # hay diamante
		if GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.CofreMineral] >=7 and numRecetasPuestas<7:
			recetas.append([GlobalRecursos.mineralesSinFondo.Cobre, GlobalRecursos.mineralesSinFondo.Topacio, GlobalRecursos.mineralesSinFondo.Esmeralda]) #  verde
			recetas.append([GlobalRecursos.mineralesSinFondo.Zafiro, GlobalRecursos.mineralesSinFondo.Hierro, GlobalRecursos.mineralesSinFondo.Diamante]) # water cri
			recetas.append([GlobalRecursos.mineralesSinFondo.Zafiro, GlobalRecursos.mineralesSinFondo.Hierro, GlobalRecursos.mineralesSinFondo.Diamante]) # water cri
			numRecetasPuestas+=1
	if GlobalTiempo.diaActual >= 9: # hay diamante
		if GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.CofreMineral] >=8 and numRecetasPuestas<8:
			recetas.append([GlobalRecursos.mineralesSinFondo.Topacio, GlobalRecursos.mineralesSinFondo.Oro, GlobalRecursos.mineralesSinFondo.Rubi]) #fire cri
			recetas.append([GlobalRecursos.mineralesSinFondo.Plata, GlobalRecursos.mineralesSinFondo.Amatista, GlobalRecursos.mineralesSinFondo.Zafiro]) # frost cri
			numRecetasPuestas+=1
	if GlobalTiempo.diaActual >= 10: # hay diamante}
		if GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.CofreMineral] >=9 and numRecetasPuestas<9:
			recetas.append([GlobalRecursos.mineralesSinFondo.Cobre, GlobalRecursos.mineralesSinFondo.Topacio, GlobalRecursos.mineralesSinFondo.Esmeralda]) #  verde
			recetas.append([GlobalRecursos.mineralesSinFondo.Zafiro, GlobalRecursos.mineralesSinFondo.Hierro, GlobalRecursos.mineralesSinFondo.Diamante]) # water cri
			recetas.append([GlobalRecursos.mineralesSinFondo.Rubi, GlobalRecursos.mineralesSinFondo.Zafiro, GlobalRecursos.mineralesSinFondo.Esmeralda]) #  rgb cri
			numRecetasPuestas+=1
	if GlobalTiempo.diaActual >= 12: # hay diamante
		if GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.CofreMineral] >=10 and numRecetasPuestas<10:
			recetas.append([GlobalRecursos.mineralesSinFondo.Topacio, GlobalRecursos.mineralesSinFondo.Oro, GlobalRecursos.mineralesSinFondo.Rubi]) #fire cri
			recetas.append([GlobalRecursos.mineralesSinFondo.Plata, GlobalRecursos.mineralesSinFondo.Amatista, GlobalRecursos.mineralesSinFondo.Zafiro]) # frost cri
			recetas.append([GlobalRecursos.mineralesSinFondo.Cobre, GlobalRecursos.mineralesSinFondo.Topacio, GlobalRecursos.mineralesSinFondo.Esmeralda]) #  verde
			recetas.append([GlobalRecursos.mineralesSinFondo.Zafiro, GlobalRecursos.mineralesSinFondo.Hierro, GlobalRecursos.mineralesSinFondo.Diamante]) # water cri
			recetas.append([GlobalRecursos.mineralesSinFondo.Rubi, GlobalRecursos.mineralesSinFondo.Zafiro, GlobalRecursos.mineralesSinFondo.Esmeralda]) #  rgb cri
			numRecetasPuestas+=1
	if GlobalTiempo.diaActual >= 15: # hay diamante
		if GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.CofreMineral] >=11 and numRecetasPuestas<11:
			recetas.append([GlobalRecursos.mineralesSinFondo.Topacio, GlobalRecursos.mineralesSinFondo.Oro, GlobalRecursos.mineralesSinFondo.Rubi]) #fire cri
			recetas.append([GlobalRecursos.mineralesSinFondo.Plata, GlobalRecursos.mineralesSinFondo.Amatista, GlobalRecursos.mineralesSinFondo.Zafiro]) # frost cri
			recetas.append([GlobalRecursos.mineralesSinFondo.Cobre, GlobalRecursos.mineralesSinFondo.Topacio, GlobalRecursos.mineralesSinFondo.Esmeralda]) #  verde
			recetas.append([GlobalRecursos.mineralesSinFondo.Zafiro, GlobalRecursos.mineralesSinFondo.Hierro, GlobalRecursos.mineralesSinFondo.Diamante]) # water cri
			recetas.append([GlobalRecursos.mineralesSinFondo.Rubi, GlobalRecursos.mineralesSinFondo.Zafiro, GlobalRecursos.mineralesSinFondo.Esmeralda]) #  rgb cri
			numRecetasPuestas+=1
	
	
# Señales

func _on_new_customer(customer : Cliente) -> void:
	var tempOrder = OrderGem.new(recetas.pick_random(), customer)

	currentOrders.append(tempOrder)
	new_order.emit(tempOrder)
	
	
func _on_order_delivered(plata : int) -> void:
	var dineroordenbase=plata
	@warning_ignore("integer_division")
	# cada nivel de la mejora de dinero agrega 25% más al precio de cada receta +1
	var dinerobono=((plata / 4) * GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.RecompensaMejorada])\
	 + (1 * GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.RecompensaMejorada])
	GlobalRecursos.Gananciadia+=dineroordenbase
	GlobalRecursos.Gananciabono+=dinerobono
	GlobalRecursos.actualizar_dinero(plata+dinerobono)
	if GlobalTuto.tutorial and GlobalTuto.FlagOrdenEscalera:
		GlobalTuto.ordenToEscaleras.emit()
