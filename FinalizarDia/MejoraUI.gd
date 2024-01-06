extends VBoxContainer

var info : Dictionary
var textura 
func _ready() -> void:
	if not info.is_empty():
		$Lb_nombre.text = info["Nombre"]
		$Lb_precio.text = "Precio: " + str(info["Precio"])
		$Lb_desc.text = str(info["Descripcion"])
		textura = load(info["Textura"])
		$TextureRect.texture = textura

func _on_btn_comprar_pressed() -> void:
	if not info.is_empty():
		if GlobalRecursos.dinero - int(info["Precio"]) >= 0:
			GlobalRecursos.actualizar_dinero(-int(info["Precio"]))
			$AudioDineroAlcanza.play(0)
			$Btn_comprar.disabled = true
			# solo puede comprar una vez hasta el maximo
			GlobalMejoras.activas_mejoras[int(info["Key"])] += 1
			GlobalMejoras.disponible_mejoras[int(info["Key"])] -= 1
			GlobalMejoras.mejora_cambiada.emit()
			
		else:
			$AudioDineroNoAlcanza.play(0)
			$Btn_comprar.disabled = true
