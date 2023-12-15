extends VBoxContainer

var ordenUI = preload("res://Escenas/Ventana por Orden/orden_ui.tscn")
#var dirSprites = "res://Sprites/temporales_UI"

func _ready():
	OrderManager.new_order.connect(_on_new_order)
	GlobalTiempo.finalizarDia.connect(limpiar_ordenes)
	
# Llamadas

func entregarOrden(objetivo):
	for orden in get_children():
		if orden.getOrden() == objetivo:
			orden.orden_deliver()
			return 
			
func limpiar_ordenes():
	for orden in get_children():
		orden.free()
# Señales

func _on_new_order(orden : Order):
	var temp = ordenUI.instantiate()
	temp.setOrden(orden)
	add_child(temp)
	

	
