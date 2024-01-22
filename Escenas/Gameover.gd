extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalRecursos.bancarota.connect(gameover)

func gameover():
	visible = true
	$AudioGameover.play(0)


func _on_btn_reintentar_pressed() -> void:
	GlobalRecursos.dinero = 5
	GlobalRecursos.minerales = [0,0,0,0,0,0,0,0,0,0,0]
	GlobalMejoras.activas_mejoras = [0,0,0,0,0,0,0]
	GlobalMejoras._ready()
	GlobalTiempo.diaActual = 1
	GlobalTiempo.tiempoHoraDia = 8
	GlobalTiempo.tiempoMinutoDia = 0
	
	get_tree().call_deferred("change_scene_to_file","res://Escenas/game_start.tscn")
