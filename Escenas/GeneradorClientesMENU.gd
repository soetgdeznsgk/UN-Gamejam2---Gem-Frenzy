extends Marker2D

var cliente = preload("res://Logica/cliente_body.tscn")
@export var tiempo_max_entre_clientes = 12 # añadir varianza
var generandoClientes = true
var tiempo_min_entre_clientes = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generar_cliente()
	tiempo_max_entre_clientes=5
	#GlobalTiempo.finalizarDia.connect(fin_dia)
	#GlobalTiempo.iniciarDia.connect(ini_dia)

func generar_cliente():
	if generandoClientes:
		var temp = cliente.instantiate()
		temp.position = position
		get_parent().add_child.call_deferred(temp)
		temp.get_child(4).volume_db=-70
		temp.get_child(5).volume_db=-70
func _on_timer_timeout():
	$Timer.wait_time = 20
	generar_cliente()


func _on_timerchaocliente_timeout():
	var cliente=get_parent().get_child(8)
	if cliente!=null:
		cliente.esperando=false

	pass # Replace with function body.
