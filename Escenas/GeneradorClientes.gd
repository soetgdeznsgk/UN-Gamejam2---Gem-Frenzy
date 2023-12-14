extends Marker2D

var cliente = preload("res://Logica/cliente_body.tscn")
@export var tiempo_min_entre_clientes := 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generar_cliente()

func generar_cliente():
	var temp = cliente.instantiate()
	temp.position = position
	get_parent().add_child.call_deferred(temp)

#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("ui_cancel"):
		#generar_cliente()



func _on_timer_timeout():
	$Timer.wait_time = randi() % (5) + tiempo_min_entre_clientes - (GlobalMejoras.activas_mejoras[5] * 2) # cada nivel del gato disminuye 2 segundos el tiempo de aparecido de clientes
	generar_cliente()
