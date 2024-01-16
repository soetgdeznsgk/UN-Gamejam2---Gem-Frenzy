extends Marker2D

var cliente = preload("res://Logica/cliente_body.tscn")
@export var tiempo_min_entre_clientes = 12 # añadir varianza
var generandoClientes = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generar_cliente()
	GlobalTiempo.finalizarDia.connect(fin_dia)
	GlobalTiempo.iniciarDia.connect(ini_dia)

func fin_dia():
	generandoClientes = false
	$Timer.stop()
	
func ini_dia():
	generandoClientes = true
	$Timer.start(2)

func generar_cliente():
	if generandoClientes:
		var temp = cliente.instantiate()
		temp.position = position
		get_parent().add_child.call_deferred(temp)

func _on_timer_timeout():
	if len(OrderManager.currentOrders) > 0:
		$Timer.wait_time = randi() % (7) + randi_range(7,tiempo_min_entre_clientes) - (GlobalMejoras.activas_mejoras[5] * 2) # cada nivel del gato disminuye 2 segundos el tiempo de aparecido de clientes
	else:
		$Timer.wait_time = randi() % (4) + randi_range(6,tiempo_min_entre_clientes) - (GlobalMejoras.activas_mejoras[5] * 2) # cada nivel del gato disminuye 2 segundos el tiempo de aparecido de clientes
	generar_cliente()
