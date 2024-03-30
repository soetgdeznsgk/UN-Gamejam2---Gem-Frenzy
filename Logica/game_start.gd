extends Control
var sound = true
var textureSnd1 = load("res://Sprites/UI/Icon_SoundOff.png")
var textureSnd2 = load("res://Sprites/UI/Icon_SoundOn.png")
var situto=load("res://Sprites/UI/yes.png")
var notuto=load("res://Sprites/UI/no.png")
func _ready():
	#TEST
	var nodo_Btn=$Lenguaje/PanelContainer/MarginContainer/VBoxContainer
	for i in range(1,nodo_Btn.get_child_count()):
		var boton=nodo_Btn.get_child(i)
		boton.pressed.connect(_on_button_language_pressed.bind(boton.name))
	print("estoy en el menu")
	#TranslationServer.set_locale("es")
	#GlobalMejoras.actualizar_traducciones()
	update_sound_texture()
	update_tuto_texture()
	
func _on_btn_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://intro_anim.tscn")

func _on_btn_toggle_sound_pressed() -> void:
	sound = !sound
	update_sound_texture()

func update_sound_texture():
	if sound:
		AudioServer.set_bus_volume_db(0,0)
		$Sprite2D.texture = textureSnd2
	else:
		AudioServer.set_bus_volume_db(0,-72)
		$Sprite2D.texture = textureSnd1	
func _on_btn_toggle_tutorial_pressed():
	if GlobalTuto.tutorial:
		GlobalTuto.tutorial=false
		$tutorial.texture=notuto
	else:
		GlobalTuto.tutorial=true
		$tutorial.texture=situto	
	pass # Replace with function body.
func update_tuto_texture():
	if GlobalTuto.tutorial:
		$tutorial.texture=situto
		
	else:
		$tutorial.texture=notuto


# Replace with function body.


func _on_button_language_pressed(language):
	TranslationServer.set_locale(language)
	GlobalMejoras.actualizar_traducciones()
	print(language)
	pass # Replace with function body.


func _on_btn_language_toggle_pressed():
	$Lenguaje.visible=true
	pass # Replace with function body.


func _on_btn_close_language_pressed():
	$Lenguaje.visible=false
	pass # Replace with function body.
