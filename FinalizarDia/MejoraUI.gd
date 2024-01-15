extends VBoxContainer

var info : Dictionary
var textura 
var totalPrecio
func _ready() -> void:
	if not info.is_empty():
		# el precio aumenta en 2 por cada mejora de la misma
		totalPrecio = info["Precio"] + \
		GlobalMejoras.activas_mejoras[int(info["Key"])] * 2
		
		$Lb_nombre.text = info["Nombre"]
		$Lb_precio.text = tr("Precio") + ": " + str(info["Precio"])
		%Lb_desc.text = tr(str(info["Descripcion"]))
		textura = load(info["Textura"])
		$TextureRect.texture = textura

func _on_btn_comprar_pressed() -> void:
	if not info.is_empty():
		if GlobalRecursos.dinero - totalPrecio >= 0:
			GlobalRecursos.actualizar_dinero(-totalPrecio)
			$AudioDineroAlcanza.play(0)
			$Btn_comprar.disabled = true
			# solo puede comprar una vez hasta el maximo
			GlobalMejoras.activas_mejoras[int(info["Key"])] += 1
			GlobalMejoras.disponible_mejoras[int(info["Key"])] -= 1
			GlobalMejoras.mejora_cambiada.emit()
			
		else:
			$AudioDineroNoAlcanza.play(0)
			$Btn_comprar.disabled = true
