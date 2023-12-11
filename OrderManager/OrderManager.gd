extends Node2D

#var materiales := Array() # array de materiales 
var recetas := Array()
@onready var currentOrders := Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	recetas.append([1, 2, 3])
	recetas.append([4, 5])
	recetas.append([9])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
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
	

