extends Node

signal new_order(orden: Order)
#var materiales := Array() # array de materiales 
var recetas := Array()
@onready var currentOrders := Array()

@onready var tmr := Timer.new()

var SpritesMaterialesPaths = {
	GlobalRecursos.Carbon : "res://Sprites/temporales_UI/carbontemp.png",
	GlobalRecursos.Diamante : "",
	GlobalRecursos.Cobre : "",
	GlobalRecursos.Esmeralda : "",
	GlobalRecursos.Uranio : "",
	GlobalRecursos.Platino : "",
	GlobalRecursos.Plata : "",
	GlobalRecursos.Oro : ""
}

# Called when the node enters the scene tree for the first time.
func _ready():
	# conectarse con la cascada del UI
	#recetas.append([1, 2, 3])
	#recetas.append([4, 5])
	recetas.append([9])
	
	add_child(tmr)
	tmr.timeout.connect(_on_timer_timeout)
	tmr.wait_time = 3
	tmr.one_shot = false
	tmr.process_callback = Timer.TIMER_PROCESS_PHYSICS
	tmr.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(_event):
	if Input.is_anything_pressed():
		if currentOrders.size() > 1:
			entregarOrden(currentOrders[0])
# Llamadas

func entregarOrden(orden : Order):
	var i = currentOrders.find(orden)
	if i != -1:
		print("se entrega: ", currentOrders[i])
		currentOrders.pop_at(i)
		print("queda: ", currentOrders)
		#DARLE DINERO AL JUGADOR
		return
	else:
		return
		
		
# Señales
func _on_timer_timeout() -> void: # añadir 
	var tempOrder = Order.new(recetas.pick_random())
	currentOrders.append(tempOrder)
	print("ordenes actuales: ", currentOrders)
	new_order.emit(tempOrder)
	

