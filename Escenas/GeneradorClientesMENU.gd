extends Marker2D

var clienteScn = preload("res://Logica/cliente_body.tscn")
var generandoClientes = true
var cliente
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generar_cliente()

func generar_cliente():
	if generandoClientes:
		cliente = clienteScn.instantiate()
		cliente.position = position
		get_parent().add_child.call_deferred(cliente)
		cliente.get_child(4).volume_db=-70
		cliente.get_child(5).volume_db=-70
		$timerchaocliente.start()


func _on_timer_timeout():
	generar_cliente()


func _on_timerchaocliente_timeout():
	cliente.esperando=false
	$Timer.start()
