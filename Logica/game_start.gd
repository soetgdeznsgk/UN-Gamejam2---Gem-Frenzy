extends Control
var sound = true
var textureSnd1 = load("res://Sprites/UI/Icon_SoundOff.png")
var textureSnd2 = load("res://Sprites/UI/Icon_SoundOn.png")

func _on_btn_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://intro_anim.tscn")


func _on_btn_toggle_sound_pressed() -> void:
	sound = !sound
	if sound:
		AudioServer.set_bus_volume_db(0,0)
		$Sprite2D.texture = textureSnd1
	else:
		AudioServer.set_bus_volume_db(0,-72)
		$Sprite2D.texture = textureSnd2
