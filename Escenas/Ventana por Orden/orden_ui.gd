class_name OrdenUI
extends Control

signal sonido_orden_out_of_time

@export var Dimension := 32

@onready var pb = $VBoxContainer/ProgressBar
var orden_logica : Order
@onready var cambiadorDeColor = StyleBoxFlat.new()
#var cliente_asociado : Cliente

func _ready():
	cambiadorDeColor.bg_color = Color("008000")
	pb.add_theme_stylebox_override("fill", cambiadorDeColor)
	pb.max_value = orden_logica.get_time_left() # ésto dará error si se instancia antes que la orden
	
func _physics_process(_delta):
	pb.value = orden_logica.get_time_left()
	if pb.value == 20:
		cambiadorDeColor.bg_color = Color("FFFF00")
		
	elif pb.value == 10:
		cambiadorDeColor.bg_color = Color("FF0000")
		

# Llamadas

func getOrden() -> int:
	return GlobalRecetas.encontrarReceta(orden_logica.requirements)

func setOrden(orden : Order) -> void:
	#cliente_asociado = cliente
	orden_logica = orden
	add_child(orden)
	orden.out_of_time.connect(orden_out_of_time)
	
	var t = orden.requirements.size()
	for i in range(t):
		$VBoxContainer/HBoxContainer.get_child((i + t + 1) % t).frame = orden.requirements[i]
	$recetaSprite.frame = GlobalRecetas.encontrarReceta(orden.requirements) # revisar

func free():
	orden_logica.queue_free()
	queue_free()
	
# Señales

func orden_out_of_time():
	sonido_orden_out_of_time.emit()
	orden_logica.queue_free()
	queue_free()
	
func orden_deliver():
	OrderManager._on_order_delivered(orden_logica.precio)
	orden_logica._on_timer_timeout()
	queue_free()
	
