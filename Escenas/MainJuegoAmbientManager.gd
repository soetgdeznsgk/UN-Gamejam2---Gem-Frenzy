extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalTuto.tutorial:
			#gato bonito
		GlobalMejoras.activas_mejoras[5]=1
		GlobalMejoras.mejora_cambiada.emit()
		#print("señal gato")
	GlobalRecursos.bancarota.connect(noSound)
	GlobalTiempo.finalizarDia.connect(noSound)
	
	GlobalTiempo.iniciarDia.connect(playSound)
	$Ambient.play(0)
# Señales

func playSound():
	$Ambient.play(0)

func noSound():
	$Ambient.stop()
