extends Node2D
var nueva_cancion=preload("res://Musica/Theme_Happy.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalTiempo.winner.connect(winner)
	if GlobalTuto.tutorial:
		
		$Ambient.stream=nueva_cancion
		$Ambient.volume_db=-6.521
		$Ambient.play()
		#gato bonito
		GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.Gato]=1
		GlobalMejoras.mejora_cambiada.emit()
	else:
		GlobalTiempo.start_time()
	GlobalRecursos.bancarota.connect(noSound)
	GlobalTiempo.finalizarDia.connect(noSound)
	GlobalTiempo.iniciarDia.connect(playSound)
	if GlobalTiempo.diaActual>6:
		$Ambient.stream=nueva_cancion
		$Ambient.volume_db=-6.521
		$Ambient.play()

# Señales

func playSound():

	$Ambient.play(0)

func noSound():
	$Ambient.stop()

func winner():
	# si gana pausa la cancion actual
	$Ambient.stop()
