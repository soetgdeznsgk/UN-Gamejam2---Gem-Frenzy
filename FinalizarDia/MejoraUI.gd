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

func _on_btn_comprar_pressed() -> void:
	if not info.is_empty():
		if GlobalRecursos.dinero - totalPrecio >= 0:
			GlobalRecursos.actualizar_dinero(-totalPrecio)
			$AudioDineroAlcanza.play(0)
			$Btn_comprar.disabled = true
			# solo puede comprar una vez hasta el maximo
			if $Lb_nombre.text ==tr("CONTRACT"):
				GlobalMejoras.mejora_final_comprada=true
				$TextureRect.modulate=Color("#ffffff00")
				#.visible=false
				#print(get_parent().name)

				#%Gameover/VBoxContainer/HBoxContainer/Btn_HOME.visible=false
				#%AP_PANCHALOADING.play("pancha_loading")
				get_parent().get_parent().get_parent().get_parent().get_node("ADVERTENCIAFINAL").visible=true
				
				
				#%Panchacorazon.visible=false
				#%Gameover.visible=true	
				
			GlobalMejoras.activas_mejoras[int(info["Key"])] += 1
			GlobalMejoras.disponible_mejoras[int(info["Key"])] -= 1
			GlobalMejoras.mejora_cambiada.emit()
			
		else:
			$AudioDineroNoAlcanza.play(0)
			$Btn_comprar.disabled = true
