extends VBoxContainer

var info : Dictionary

func _ready() -> void:
	$Lb_nombre.text = info["Nombre"]
	$Lb_precio.text = "Precio: " + str(info["Precio"])

func _on_btn_comprar_pressed() -> void:
	# solo puede comprar una vez hasta el maximo
	GlobalMejoras.activas_mejoras[int(info["Key"])] += 1
	GlobalRecursos.actualizar_dinero(-int(info["Precio"]))
	$Btn_comprar.disabled = true
