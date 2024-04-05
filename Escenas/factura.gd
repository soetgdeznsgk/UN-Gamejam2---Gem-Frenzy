extends Control

func _on_btn_factura_pressed():
	%FinalizarDia.visible=true
	if GlobalRecursos.dinero<0:
		%Gameover.visible=true
	self.visible=false

