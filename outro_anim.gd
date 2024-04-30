extends Node2D
signal endOutro

func _on_button_pressed():
	# Skip animacion, pone todo al final de la animación y quita el botón
	$Button.visible = false
	endOutro.emit()

func _on_visibility_changed() -> void:
	if visible:
		#llamar animaciones y cosas
		pass
