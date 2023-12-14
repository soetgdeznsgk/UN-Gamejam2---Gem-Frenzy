extends VBoxContainer

var info : Dictionary

func _ready() -> void:
	if not info.is_empty():
		$Lb_nombre.text = info["Nombre"]
		$Lb_precio.text = "Precio: " + str(info["Precio"])

func _on_btn_comprar_pressed() -> void:
	if not info.is_empty():
		# solo puede comprar una vez hasta el maximo
		GlobalMejoras.activas_mejoras[int(info["Key"])] += 1
		GlobalMejoras.disponible_mejoras[int(info["Key"])] -= 1
		
		GlobalRecursos.actualizar_dinero(-int(info["Precio"]))
		$Btn_comprar.disabled = true
