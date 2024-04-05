extends Control
var gameover:bool

func _on_btn_factura_pressed():
	
	$AnimationPlayer.play("sello epico")
	if GlobalRecursos.dinero<0:
		$signaturepancha.frame=1
		gameover=true


func pasar_de_pagina():
	%FinalizarDia.visible=true
	if gameover:
		%Gameover.visible=true
	self.visible=false
	$signaturepancha.frame=0
	$signaturepancha.visible=false
