extends Node

signal new_order(orden: Order)
#var materiales := Array() # array de materiales 
var recetas := Array()
@onready var currentOrders := Array()

@onready var tmr := Timer.new()
var SpritesPath = preload("res://Sprites/Mapa/minerales_sprites.tscn")
var Sprites : Sprite2D

#var SpritesMaterialesPaths = {
	#GlobalRecursos.Carbon : 4,
	#GlobalRecursos.Hierro : 1,
	#GlobalRecursos.Diamante : 11,
	#GlobalRecursos.Cobre : ,
	#GlobalRecursos.Esmeralda : "",
	#GlobalRecursos.Plata : "",
	#GlobalRecursos.Oro : "",
	#GlobalRecursos.Amatista: "",
	#GlobalRecursos.Zafiro: "",
	#GlobalRecursos.Rubi: "",
	#GlobalRecursos.Topacio: ""	
#}

# Called when the node enters the scene tree for the first time.
func _ready():
	recetas.append([GlobalRecursos.Carbon, GlobalRecursos.Hierro, GlobalRecursos.Diamante])
	recetas.append([GlobalRecursos.Carbon, GlobalRecursos.Hierro])
	recetas.append([GlobalRecursos.Carbon])
	
	#Sprites = SpritesPath.instantiate() # pa eliminar
	
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
	

