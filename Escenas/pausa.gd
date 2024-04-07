extends HBoxContainer
var textureSndOff = load("res://Sprites/UI/sound_mute.png")
var textureSndOn = load("res://Sprites/UI/sound_on.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	#var valoraudio=AudioServer.get_bus_volume_db(0)
	if GlobalSettings.sound:
		$Btn_toggle_sound.icon=textureSndOn
	else:
		$Btn_toggle_sound.icon=textureSndOff

func _on_btn_toggle_sound_pressed():
	if GlobalSettings.sound:
		AudioServer.set_bus_volume_db(0,-72)
		$Btn_toggle_sound.icon=  textureSndOff
	else:
		AudioServer.set_bus_volume_db(0,0)
		$Btn_toggle_sound.icon=  textureSndOn# Replace with function body.
	pass # Replace with function body.


func _on_btn_home_pressed():
	get_tree().paused = false
	GlobalRecursos.dinero = 5
	GlobalRecursos.reiniciar_minerales()
	GlobalMejoras.reiniciar_mejoras()
	GlobalMejoras._ready()
	GlobalTiempo.diaActual = 1
	GlobalTiempo.tiempoHoraDia = 8
	GlobalTiempo.tiempoMinutoDia = 0
	OrderManager.reiniciar_recetas()
	get_tree().call_deferred("change_scene_to_file","res://Escenas/game_start.tscn")
	
