extends Node2D
#  Array de musica para precargar la musica
var lista_musica= [
	preload("res://Musica/Music_LuisManzano/GF_musx_jugable1_V1.wav"),
	preload("res://Musica/Music_LuisManzano/GF_musx_jugable2_V1.wav")
]

# Array de musica desbloqueada
var lista_musica_unlock = []
# Array de musica bloqueada
var lista_musica_to_unlock = []

func _ready():
	GlobalTiempo.winner.connect(winner)
	if GlobalTuto.tutorial:
		$Ambient.stream=lista_musica[0]
		$Ambient.volume_db=-6.5
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
		$Ambient.stream=lista_musica[1]
		$Ambient.volume_db=-6.5
		$Ambient.play()

# Señales

func playSound():
	$Ambient.play(0)

func noSound():
	$Ambient.stop()

func winner():
	# si gana pausa la cancion actual
	$Ambient.stop()
