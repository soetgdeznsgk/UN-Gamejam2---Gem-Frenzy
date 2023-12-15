extends VBoxContainer

var ordenUI = preload("res://Escenas/Ventana por Orden/orden_ui.tscn")
#var dirSprites = "res://Sprites/temporales_UI"

func _ready():
	OrderManager.new_order.connect(_on_new_order)
	GlobalTiempo.finalizarDia.connect(limpiar_ordenes)
	
# Llamadas

func entregarOrden(objetivo):
	for orden in get_children():
		if orden is OrdenUI:
			if orden.getOrden() == objetivo:
				orden.orden_deliver()
				return 
			
func limpiar_ordenes():
	for orden in get_children():
		if orden is OrdenUI:
			orden.free()
		
func sonido_orden_perdida():
	$AudioStreamPlayer.play() # no se ejecuta el segundo día
		
# Señales

func _on_new_order(orden : Order):
	var temp = ordenUI.instantiate()
	temp.setOrden(orden)
	temp.sonido_orden_out_of_time.connect(sonido_orden_perdida)
	add_child(temp)
	

	
