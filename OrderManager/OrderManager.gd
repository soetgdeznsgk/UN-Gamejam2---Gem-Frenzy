extends Node

signal new_order(orden: Order)
#var materiales := Array() # array de materiales 
@onready var recetas := Array()
@onready var currentOrders := Array()

@onready var tmr := Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	llenar_recetas()
	add_child(tmr)
	tmr.timeout.connect(_on_timer_timeout)
	tmr.wait_time = randi() % (5) + 4
	tmr.one_shot = false
	tmr.process_callback = Timer.TIMER_PROCESS_PHYSICS
	tmr.start()

func _input(_event):
	if Input.is_anything_pressed():
		if currentOrders.size() > 1:
			entregarOrden(currentOrders[0])
			
# Llamadas

func entregarOrden(orden : Order):
	var i = currentOrders.find(orden)
	if i != -1:
		currentOrders.pop_at(i) # toca compararlo desde el entregador de comidas
		return
	else:
		return
		

func llenar_recetas() -> void:
	recetas.append([GlobalRecursos.mineralesSinFondo.Zafiro, GlobalRecursos.mineralesSinFondo.Hierro, GlobalRecursos.mineralesSinFondo.Diamante]) # water cri
	recetas.append([GlobalRecursos.mineralesSinFondo.Carbon, GlobalRecursos.mineralesSinFondo.Hierro]) # acero
	recetas.append([GlobalRecursos.mineralesSinFondo.Rubi, GlobalRecursos.mineralesSinFondo.Zafiro, GlobalRecursos.mineralesSinFondo.Esmeralda]) #  earth cri
	recetas.append([GlobalRecursos.mineralesSinFondo.Plata, GlobalRecursos.mineralesSinFondo.Cobre, GlobalRecursos.mineralesSinFondo.Hierro]) # allmetal
	recetas.append([GlobalRecursos.mineralesSinFondo.Topacio, GlobalRecursos.mineralesSinFondo.Oro, GlobalRecursos.mineralesSinFondo.Rubi]) #fire cri
	recetas.append([GlobalRecursos.mineralesSinFondo.Plata, GlobalRecursos.mineralesSinFondo.Amatista, GlobalRecursos.mineralesSinFondo.Zafiro]) # frost cri
	
# Señales

func _on_timer_timeout() -> void: # añadir efecto de sonido de spawn de orden
	var tempOrder = Order.new(recetas.pick_random())
	currentOrders.append(tempOrder)
	new_order.emit(tempOrder)
	
func _on_order_delivered() -> void:
	GlobalRecursos.actualizar_dinero(5) # ÉSTO DEPENDE DE SI LA CANTIDAD DE DINERO POR RECETA ES ESTÁTICA (OJALÁ NO)
	pass
	
	

