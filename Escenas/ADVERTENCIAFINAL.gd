extends Control

func _on_no_pressed():
	visible=false
	GlobalRecursos.cambioDinero.emit(GlobalRecursos.dinero+10)
	GlobalRecursos.dinero+=10

func _on_si_pressed():
	%Gameover.winner()
	await get_tree().create_timer(1.5).timeout
	# TODO hacer algo durante ese segundo y medio
	visible = false
	%Gameover.visible=true


func _on_visibility_changed():
	if visible:
		# se llamó como popup
		%FinalizarDia.modulate = Color("#adadad")
	else:
		# le dieron que nao nao
		%FinalizarDia.modulate = Color("#ffffff")
