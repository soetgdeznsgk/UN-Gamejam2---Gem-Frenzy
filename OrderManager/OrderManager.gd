extends Node

signal new_order(orden: Order)
#var materiales := Array() # array de materiales 
@onready var recetas := Array()
@onready var currentOrders := Array()

@onready var tmr := Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	llenar_recetas()
	#add_child(tmr) Ésto fué reemplazado por la señal new_customer
	#tmr.timeout.connect(_on_timer_timeout)
	#tmr.wait_time = randi() % (5) + 4
	#tmr.one_shot = false
	#tmr.process_callback = Timer.TIMER_PROCESS_PHYSICS
	#tmr.start()



func entregarOrden(orden : Order):
	var i = currentOrders.find(orden)
	if i != -1:
		currentOrders.pop_at(i) # toca compararlo desde el entregador de comidas
		return
	else:
		return
		

func llenar_recetas() -> void:
	if GlobalTiempo.diaActual >= 1: # hay carbon y hierro
		recetas.append([GlobalRecursos.mineralesSinFondo.Carbon, GlobalRecursos.mineralesSinFondo.Hierro]) # acero
		if GlobalTiempo.diaActual >= 2: # hay cobre
			recetas.append([GlobalRecursos.mineralesSinFondo.Plata, GlobalRecursos.mineralesSinFondo.Cobre, GlobalRecursos.mineralesSinFondo.Hierro]) # allmetal
			if GlobalTiempo.diaActual >= 4: # dia 3 añade oro, dia 4 añade topacio y rubi
				recetas.append([GlobalRecursos.mineralesSinFondo.Topacio, GlobalRecursos.mineralesSinFondo.Oro, GlobalRecursos.mineralesSinFondo.Rubi]) #fire cri
				if GlobalTiempo.diaActual >= 6: # hay amatista y zafiro
					recetas.append([GlobalRecursos.mineralesSinFondo.Plata, GlobalRecursos.mineralesSinFondo.Amatista, GlobalRecursos.mineralesSinFondo.Zafiro]) # frost cri
					if GlobalTiempo.diaActual >= 7: # hay esmeralda
						recetas.append([GlobalRecursos.mineralesSinFondo.Rubi, GlobalRecursos.mineralesSinFondo.Zafiro, GlobalRecursos.mineralesSinFondo.Esmeralda]) #  rgb cri
						# rgb
						recetas.append([GlobalRecursos.mineralesSinFondo.Cobre, GlobalRecursos.mineralesSinFondo.Topacio, GlobalRecursos.mineralesSinFondo.Esmeralda])
						if GlobalTiempo.diaActual >= 8: # hay diamante
								recetas.append([GlobalRecursos.mineralesSinFondo.Zafiro, GlobalRecursos.mineralesSinFondo.Hierro, GlobalRecursos.mineralesSinFondo.Diamante]) # water cri

	
	
# Señales

func _on_new_customer(customer : Cliente) -> void: # añadir efecto de sonido de spawn de orden
	var tempOrder = Order.new(recetas.pick_random(), customer)
	currentOrders.append(tempOrder)
	new_order.emit(tempOrder)
	
func _on_order_delivered(plata : int) -> void:
	GlobalRecursos.actualizar_dinero(plata + ((plata / 2) * GlobalMejoras.activas_mejoras[2])) # cada nivel de la mejora de dinero agrega 50% más al precio de cada recetas
	print("precio original = ", plata, " precio tras mejora = ", plata + ((plata / 2) * GlobalMejoras.activas_mejoras[2]))
	
	

