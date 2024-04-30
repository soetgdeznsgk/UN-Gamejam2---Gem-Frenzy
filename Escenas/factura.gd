extends Control
var gameover:bool

func _on_btn_factura_pressed():
	if GlobalRecursos.dinero<0:
		$AnimationPlayer.play("sello_perder")
		gameover=true
	else:
		print("sello epico")
		$AnimationPlayer.play("sello epico")

func pasar_de_pagina():
	%FinalizarDia.visible=true
	if gameover:
		%Gameover.visible=true
	self.visible=false
	$signaturepancha.frame=0
	$signaturepancha.visible=false
