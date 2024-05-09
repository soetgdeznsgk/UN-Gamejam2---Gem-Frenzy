extends Node2D

func _ready():
	print("READY MAIN GAME")
	if GlobalTuto.tutorial:
		#gato bonito
		GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.Gato]=1
		GlobalMejoras.mejora_cambiada.emit()
	else:
		GlobalTiempo.start_time()
