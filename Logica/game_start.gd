extends Control
var sound = true
var textureSnd1 = preload("res://Sprites/UI/sound_mute.png")
var textureSnd2 = preload("res://Sprites/UI/sound_on.png")
var situto = preload("res://Sprites/UI/yes.png")
var notuto = preload("res://Sprites/UI/no.png")

func _ready():
	var nodo_Btn=$Lenguaje/PanelContainer/MarginContainer/VBoxContainer
	for i in range(1,nodo_Btn.get_child_count()):
		var boton=nodo_Btn.get_child(i)
		boton.pressed.connect(_on_button_language_pressed.bind(boton.name))
	TranslationServer.set_locale(GlobalSettings.language)
	GlobalMejoras.llenar_mejoras()
	update_sound_texture()
	update_tuto_texture()
	
func _on_btn_jugar_pressed() -> void:
	$BotonPlay.play()
	

func _on_btn_toggle_sound_pressed() -> void:
	toggle_sound_texture()

func update_sound_texture():
	if GlobalSettings.sound:
		AudioServer.set_bus_volume_db(0,0)
		$Sprite2D.texture = textureSnd2
	else:
		AudioServer.set_bus_volume_db(0,-72)
		$Sprite2D.texture = textureSnd1

func toggle_sound_texture():
	if GlobalSettings.sound:
		AudioServer.set_bus_volume_db(0,-72)
		$Sprite2D.texture = textureSnd1	

		GlobalSettings.sound=false
		
	else:
		AudioServer.set_bus_volume_db(0,0)
		$Sprite2D.texture = textureSnd2
		
		GlobalSettings.sound=true

func _on_btn_toggle_tutorial_pressed():
	$SonidoBoton.play()
	if GlobalTuto.tutorial:
		GlobalTuto.tutorial=false
		$tutorial.texture=notuto
	else:
		GlobalTuto.tutorial=true
		$tutorial.texture=situto


func update_tuto_texture():
	if GlobalTuto.tutorial:
		$tutorial.texture=situto
		
	else:
		$tutorial.texture=notuto


func _on_button_language_pressed(language):
	$SonidoBoton.play()
	GlobalSettings.language=language
	TranslationServer.set_locale(language)
	GlobalMejoras.llenar_mejoras()


func _on_btn_language_toggle_pressed():
	$SonidoBoton.play()
	$Lenguaje.visible=true
	$Btn_toggle_Tutorial.visible=false
	$Btn_credits.disabled=true

func _on_btn_close_language_pressed():
	$SonidoBoton.play()
	$Lenguaje.visible=false
	$Btn_toggle_Tutorial.visible=true
	$Btn_credits.disabled=false


func _on_btn_credits_pressed():
	$SonidoBoton.play()
	$Credits.visible=true
	$Btn_toggle_Tutorial.visible=false
	$Btn_language.disabled=true


func _on_btn_close_credits_pressed():
	$SonidoBoton.play()
	$Credits.visible=false
	$Btn_toggle_Tutorial.visible=true
	$Btn_language.disabled=false
	
func _on_boton_play_finished():
	get_tree().change_scene_to_file("res://intro_anim.tscn")
	pass # Replace with function body.
