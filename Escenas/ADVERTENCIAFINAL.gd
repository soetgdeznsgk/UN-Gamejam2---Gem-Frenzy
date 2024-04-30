extends Control

func _on_no_pressed():
	visible=false
	GlobalRecursos.cambioDinero.emit(GlobalRecursos.dinero+10)
	GlobalRecursos.dinero+=10

func _on_si_pressed():
	%Gameover.winner()
	$HBoxContainer/si.visible = false
	$HBoxContainer/no.visible = false
	%AP_PANCHALOADING.play("pancha_loading")
	$Descadvertencia.visible = false
	$Tituloadvertencia.text = tr("LOADING")
	await get_tree().create_timer(1.5).timeout
	%AP_PANCHALOADING.play("RESET")
	visible = false
	%Gameover.visible=true


func _on_visibility_changed():
	if visible:
		# se llamó como popup
		%FinalizarDia.modulate = Color("#adadad")
	else:
		# le dieron que nao nao
		%FinalizarDia.modulate = Color("#ffffff")
