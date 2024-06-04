extends Control
var gameover:bool

func _on_btn_factura_pressed():
	if GlobalRecursos.dinero<0:
		$AnimationPlayer.play("sello_perder")
		#Desbloquea mi primera chamba
		
		gameover=true
	else:
		#print("sello epico")
		$AnimationPlayer.play("sello epico")

func pasar_de_pagina():
	%FinalizarDia.visible=true
	
	if gameover:
		%FinalizarDia.visible=false
		%Gameover.visible=true
	else:
		%FinalizarDia/Musicatienda.play()
	self.visible=false
	$signaturepancha.frame=0
	$signaturepancha.visible=false
