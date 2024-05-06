extends Node2D
signal endOutro

signal endTexto
signal endHijos
func _on_button_pressed():
	# Skip animacion, pone todo al final de la animación y quita el botón
	$Button.visible = false
	var tweenfinal = get_tree().create_tween()
	tweenfinal.tween_property(self, "modulate", Color("#000000"), 3)
	await get_tree().create_timer(3).timeout
	$finalizardiabien.play()
	endOutro.emit()

func _on_visibility_changed() -> void:
	if visible:
		$AnimationPlayer.play("elfinaldepancha")
		#llamar animaciones y cosas
		pass
func play_credits_anim():
	var nodoTextos=$"Creditos textos"
	for i in range(0,4):
		tween_fade_in_and_out(nodoTextos.get_child(i),1.5)
		await endTexto
	await tween_hijos($"Creditos textos/Apoyo1")
	await tween_hijos($"Creditos textos/Assets")
	tween_fade_in($"Creditos textos/Thanks to you",1.5)
	await get_tree().create_timer(2).timeout
	var tweenfinal = get_tree().create_tween()
	tweenfinal.tween_property(self, "modulate", Color("#000000"), 3)
	await get_tree().create_timer(3.2).timeout
	$finalizardiabien.play()
	endOutro.emit()
	#$AnimationPlayer.play("creditos")
func tween_hijos(padre:Label):
	#entra el padre al chat
	tween_fade_in(padre,1.5)
	await get_tree().create_timer(1.5).timeout
	#solo se sale el hijo
	tween_fade_out(padre.get_child(0))
	await endTexto
	var padreluchoncount=padre.get_child_count()
	for i in range(1,padreluchoncount):
		var hijo=padre.get_child(i)
		hijo.visible=true
		tween_fade_in(hijo,1.5)
		await get_tree().create_timer(2.5).timeout
		
		#si quedan mas
		if i < padreluchoncount-1:
			#solo se va el hijo
			
			tween_fade_out(hijo)
			await get_tree().create_timer(0.7).timeout
		else:
			#se va el ultimo hijo y el padre al tiempo
			tween_fade_out(padre)
			
	await get_tree().create_timer(1.5).timeout
	return

func tween_fade_in_and_out(texto:Label,delay):
	var tween = get_tree().create_tween()
	tween.tween_property(texto, "modulate", Color("#ffffff"), 1)
	tween.tween_callback(tween_fade_out.bind(texto)).set_delay(delay)
func tween_fade_in(texto:Label,delay):
	var tween = get_tree().create_tween()
	tween.tween_property(texto, "modulate", Color("#ffffff"), 1)
	
	#print(texto.text)
func tween_fade_out(texto:Label):
	var tween = get_tree().create_tween()
	tween.tween_property(texto, "modulate", Color("#ffffff00"), 1)
	tween.tween_callback(emit_endTexto).set_delay(0.5)
	#tween.tween_property($Sprite, "scale", Vector2(), 1)
	
	#print(texto.text)
func emit_endTexto():
	endTexto.emit()
