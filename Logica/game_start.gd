extends Control
var sound = true
var textureSnd1 = preload("res://Sprites/UI/sound_mute.png")
var textureSnd2 = preload("res://Sprites/UI/sound_on.png")
var situto = preload("res://Sprites/UI/yes.png")
var notuto = preload("res://Sprites/UI/no.png")
func _ready():
	$AnimationPlayer.play("aparece_logo")
	var nodo_Btn=$Lenguaje/PanelContainer/MarginContainer/VBoxContainer
	for i in range(1,nodo_Btn.get_child_count()):
		var boton=nodo_Btn.get_child(i)
		boton.pressed.connect(_on_button_language_pressed.bind(boton.name))
	TranslationServer.set_locale(GlobalSettings.language)
	GlobalMejoras.llenar_mejoras()
	update_sound_texture()
	update_tuto_texture()
	var buttonsHover = get_tree().get_nodes_in_group("buttonHover")
	for i : Control in buttonsHover:
		i.pivot_offset = i.size/2
		i.mouse_entered.connect(mouse_entered_btn_hover.bind(i))
		i.mouse_exited.connect(mouse_exited_btn_hover.bind(i))
		
func mouse_entered_btn_hover(btn):
	btn.scale = Vector2(1.1,1.1)

func mouse_exited_btn_hover(btn):
	btn.scale = Vector2(1,1)


func _on_btn_jugar_pressed() -> void:
	GlobalMejoras.reiniciar_mejoras()
	$BotonPlay.play()
	

func _on_btn_toggle_sound_pressed() -> void:
	toggle_sound_texture()

func update_sound_texture():
	if GlobalSettings.sound:
		AudioServer.set_bus_volume_db(0,0)
		$Btn_toggle_sound/Sprite2D.texture = textureSnd2
	else:
		AudioServer.set_bus_volume_db(0,-72)
		$Btn_toggle_sound/Sprite2D.texture = textureSnd1

func toggle_sound_texture():
	if GlobalSettings.sound:
		AudioServer.set_bus_volume_db(0,-72)
		$Btn_toggle_sound/Sprite2D.texture = textureSnd1	

		GlobalSettings.sound=false
		
	else:
		AudioServer.set_bus_volume_db(0,0)
		$Btn_toggle_sound/Sprite2D.texture = textureSnd2
		
		GlobalSettings.sound=true

func _on_btn_toggle_tutorial_pressed():
	$SonidoBoton.play()
	if GlobalTuto.tutorial:
		GlobalTuto.tutorial=false
		$Btn_toggle_Tutorial.icon=notuto
	else:
		GlobalTuto.tutorial=true
		$Btn_toggle_Tutorial.icon=situto

func update_tuto_texture():
	if GlobalTuto.tutorial:
		$Btn_toggle_Tutorial.icon=situto
		
	else:
		$Btn_toggle_Tutorial.icon=notuto

func _on_button_language_pressed(language):
	$SonidoBoton.play()
	GlobalSettings.language=language
	TranslationServer.set_locale(language)
	GlobalMejoras.llenar_mejoras()
	GlobalMejoras.llenar_mejora_final()

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

func _on_instagram_mouse_entered():
	$Instagram.scale=Vector2(1.1,1.1)
	$Instagram.position=Vector2(867,637)

func _on_instagram_mouse_exited():
	$Instagram.scale=Vector2(1,1)
	$Instagram.position=Vector2(871,641)

func _on_twitter_mouse_entered():
	$Twitter.scale=Vector2(1.1,1.1)
	$Twitter.position=Vector2(782,633)

func _on_twitter_mouse_exited():
	$Twitter.scale=Vector2(1,1)
	$Twitter.position=Vector2(788,639)

func _on_btn_jugar_mouse_entered() -> void:
	$CenterContainer.scale=Vector2(1.15,1.15)

func _on_btn_jugar_mouse_exited() -> void:
	$CenterContainer.scale=Vector2(1,1)

func _on_btn_toggle_tutorial_mouse_entered() -> void:
	$Btn_toggle_Tutorial.scale = Vector2(1.085,1.085)

func _on_btn_toggle_tutorial_mouse_exited() -> void:
	$Btn_toggle_Tutorial.scale = Vector2(1,1)

func _on_btn_language_mouse_entered() -> void:
	$Btn_language.scale = Vector2(1.06,1.06)

func _on_btn_language_mouse_exited() -> void:
	$Btn_language.scale = Vector2(1,1)

func _on_btn_credits_mouse_entered() -> void:
	$Btn_credits.scale = Vector2(1.06,1.06)

func _on_btn_credits_mouse_exited() -> void:
	$Btn_credits.scale = Vector2(1,1)

func _on_btn_toggle_sound_mouse_entered() -> void:
	$Btn_toggle_sound.scale = Vector2(1.1,1.1)

func _on_btn_toggle_sound_mouse_exited() -> void:
	$Btn_toggle_sound.scale = Vector2(1,1)



func _on_btn_fullscreen_pressed():
	if GlobalSettings.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		GlobalSettings.fullscreen=false
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)	
		GlobalSettings.fullscreen=true
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name):
	if anim_name=="aparece_logo":
		$AnimationPlayer.play("Logo_se_mueve")
	pass # Replace with function body.
