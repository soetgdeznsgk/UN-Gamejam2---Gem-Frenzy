extends Node

signal new_order(orden: Order)
#var materiales := Array() # array de materiales 
var recetas := Array()
@onready var currentOrders := Array()

@onready var tmr := Timer.new()

var SpritesMaterialesPaths = {
	GlobalRecursos.Carbon : "res://Sprites/temporales_UI/carbontemp.png",
	GlobalRecursos.Hierro : "res://Sprites/temporales_UI/hierrotemp.png",
	GlobalRecursos.Diamante : "res://Sprites/temporales_UI/diamantetemp.png",
	GlobalRecursos.Cobre : "",
	GlobalRecursos.Esmeralda : "",
	GlobalRecursos.Uranio : "",
	GlobalRecursos.Plata : "",
	GlobalRecursos.Oro : ""#,
	#GlobalRecursos.Amatista: "",
	#GlobalRecursos.Zafiro: "",
	#GlobalRecursos.Rubi: "",
	#GlobalRecursos.Topacio: ""	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	recetas.append([GlobalRecursos.Carbon, GlobalRecursos.Hierro, GlobalRecursos.Diamante])
	recetas.append([GlobalRecursos.Carbon, GlobalRecursos.Hierro])
	recetas.append([GlobalRecursos.Carbon])
	
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
		currentOrders.pop_at(i) # toca compararlo desde el entregador de comidas
		return
	else:
		return
		
		
# Señales
func _on_timer_timeout() -> void: # añadir 
	var tempOrder = Order.new(recetas.pick_random())
	currentOrders.append(tempOrder)
	new_order.emit(tempOrder)
	

