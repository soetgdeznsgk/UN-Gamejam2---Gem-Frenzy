extends VBoxContainer

var info : Dictionary
var textura 
var totalPrecio

func _ready() -> void:
	if not info.is_empty():
		# el precio aumenta algun escalar si ya se ha comprado antes
		totalPrecio = info["Precio"] + \
		GlobalMejoras.activas_mejoras[int(info["Key"])] * info["PrecioEscalar"]
		
		$Lb_nombre.text = info["Nombre"]
		$"HBoxContainer/Lb_precio".text = str(totalPrecio)
		%Lb_desc.text = tr(str(info["Descripcion"]))
		textura = load(info["Textura"])
		$TextureRect.texture = textura
		
		# Se deshabilita si no alcanza el dinero
		update()
		GlobalMejoras.mejora_cambiada.connect(update)

func update():
	if GlobalRecursos.dinero - totalPrecio <0:
			$Btn_comprar.disabled = true
			$Btn_comprar/TextureRect2.visible=true

func _on_btn_comprar_pressed() -> void:
	if not info.is_empty():
		if GlobalRecursos.dinero - totalPrecio >= 0:
			GlobalRecursos.actualizar_dinero(-totalPrecio)
			$AudioDineroAlcanza.play(0)
			# solo puede comprar una vez hasta el maximo
			$Btn_comprar.disabled = true
			GlobalMejoras.mejora_cambiada.disconnect(update)
			
			#CONTRATO
			if $Lb_nombre.text ==tr("CONTRACT"):
				GlobalMejoras.mejora_final_comprada=true
				$TextureRect.modulate=Color("#ffffff00")
				# POP UP AL COMPRAR CONTRATO
				get_parent().get_parent().get_parent().get_parent().get_node("ADVERTENCIAFINAL").visible=true
				
			GlobalMejoras.activas_mejoras[int(info["Key"])] += 1
			GlobalMejoras.disponible_mejoras[int(info["Key"])] -= 1
			GlobalMejoras.mejora_cambiada.emit()
			

