extends Marker2D

var cliente = preload("res://Logica/cliente_body.tscn")
@export var tiempo_max_entre_clientes = 12 # añadir varianza
var generandoClientes = true
var tiempo_min_entre_clientes = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generar_cliente()
	GlobalTiempo.finalizarDia.connect(fin_dia)
	GlobalTiempo.iniciarDia.connect(ini_dia)
	if GlobalTiempo.diaActual == 1:
		tiempo_max_entre_clientes = 7
		tiempo_min_entre_clientes = 5

func fin_dia():
	generandoClientes = false
	$Timer.stop()
	
func ini_dia():
	generandoClientes = true
	$Timer.start(2)
	if GlobalTiempo.diaActual != 1:
		@warning_ignore("integer_division")
		tiempo_max_entre_clientes = 7 + int(GlobalTiempo.diaActual/2)
		@warning_ignore("integer_division")
		tiempo_min_entre_clientes = 5 + int(GlobalTiempo.diaActual/2)
	if tiempo_max_entre_clientes >= 13:
		tiempo_max_entre_clientes = 13
	if tiempo_min_entre_clientes >= 10:
		tiempo_min_entre_clientes = 10

func generar_cliente():
	if generandoClientes:
		var temp = cliente.instantiate()
		temp.position = position
		get_parent().add_child.call_deferred(temp)
	if GlobalTuto.tutorial:
		$Timer.stop()

func _on_timer_timeout():
	$Timer.wait_time = randi_range(tiempo_min_entre_clientes,tiempo_max_entre_clientes) + randi_range(tiempo_min_entre_clientes,tiempo_max_entre_clientes) - (GlobalMejoras.activas_mejoras[5] * 2) # cada nivel del gato disminuye 2 segundos el tiempo de aparecido de clientes
	generar_cliente()
