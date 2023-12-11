extends Control

func setOrden(orden : Order) -> void:
	print("se carga la imagen: ", OrderManager.SpritesMaterialesPaths.get(GlobalRecursos.Carbon))
	var t1 := TextureRect.new()
	t1.texture = load(OrderManager.SpritesMaterialesPaths.get(GlobalRecursos.Carbon))
	if (orden.requirements.size()) == 1:
		$VBoxContainer/HBoxContainer.add_child(t1)
		return
		
	else:
		var t2 := TextureRect.new()
		# asignar textura a t2
		if (orden.requirements.size()) == 2:
			$VBoxContainer/HBoxContainer.add_child(t1)
			$VBoxContainer/HBoxContainer.add_child(t2)
			return
		else:
			var t3 := TextureRect.new()
			# asignar textura a t3
			$VBoxContainer/HBoxContainer.add_child(t1)
			$VBoxContainer/HBoxContainer.add_child(t2)
			$VBoxContainer/HBoxContainer.add_child(t3)
			return
			
	
