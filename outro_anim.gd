extends Node2D
signal endOutro

signal endTexto
func _on_button_pressed():
	# Skip animacion, pone todo al final de la animación y quita el botón
	$Button.visible = false
	endOutro.emit()

func _on_visibility_changed() -> void:
	if visible:
		$AnimationPlayer.play("elfinaldepancha")
		#llamar animaciones y cosas
		pass
func play_credits_anim():
	var nodoTextos=$"Creditos textos"
	for i in range(0,nodoTextos.get_child_count()):
		tween_fade_in(nodoTextos.get_child(i),1.5)
		await endTexto
	#$AnimationPlayer.play("creditos")
	
func tween_fade_in(texto:Label,delay):
	var tween = get_tree().create_tween()
	tween.tween_property(texto, "modulate", Color("#ffffff"), 1)
	tween.tween_callback(tween_fade_out.bind(texto)).set_delay(delay)
	print(texto.text)
func tween_fade_out(texto:Label):
	var tween = get_tree().create_tween()
	tween.tween_property(texto, "modulate", Color("#ffffff00"), 1)
	tween.tween_callback(emit_endTexto).set_delay(0.5)
	#tween.tween_property($Sprite, "scale", Vector2(), 1)
	
	print(texto.text)
func emit_endTexto():
	endTexto.emit()
