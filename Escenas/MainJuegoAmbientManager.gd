extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalRecursos.bancarota.connect(noSound)
	GlobalTiempo.finalizarDia.connect(noSound)
	
	GlobalTiempo.iniciarDia.connect(playSound)
	$Ambient.play(0)
# Señales

func playSound():
	$Ambient.play(0)

func noSound():
	$Ambient.stop()
