extends Marker2D

var cliente = preload("res://Logica/cliente_body.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generar_cliente()

func generar_cliente():
	var temp = cliente.instantiate()
	temp.position = position
	get_parent().add_child.call_deferred(temp)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		generar_cliente()
