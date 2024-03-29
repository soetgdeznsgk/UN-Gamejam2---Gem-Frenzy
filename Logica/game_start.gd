extends Control
var sound = true
var textureSnd1 = load("res://Sprites/UI/Icon_SoundOff.png")
var textureSnd2 = load("res://Sprites/UI/Icon_SoundOn.png")
var situto=load("res://Sprites/UI/yes.png")
var notuto=load("res://Sprites/UI/no.png")
func _ready():
	#TEST
	print("estoy en el menu")
	TranslationServer.set_locale("en")
	GlobalMejoras.actualizar_traducciones()
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
