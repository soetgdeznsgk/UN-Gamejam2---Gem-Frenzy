extends Node2D
#  Array de musica para precargar la musica
var lista_musica= [
	preload("res://Musica/Music_LuisManzano/GF_musx_jugable1_V1_largo.wav"),
	preload("res://Musica/Music_LuisManzano/GF_musx_jugable2_V1_largo.wav"),
	preload("res://Musica/Music_LuisManzano/GF_musx_jugable3_V1_largo.wav"),
	preload("res://Musica/Music_LuisManzano/GF_musx_jugable4_V1_larga.wav")
]

# Array de musica desbloqueada
var lista_musica_unlocked = [preload("res://Musica/Music_LuisManzano/GF_musx_jugable1_V1_largo.wav")]
# Array de musica bloqueada
#var lista_musica_to_unlock = [
	#preload("res://Musica/Music_LuisManzano/GF_musx_jugable2_V1_largo.wav"),
	#preload("res://Musica/Music_LuisManzano/GF_musx_jugable3_V1_largo.wav"),
	#preload("res://Musica/Music_LuisManzano/GF_musx_jugable4_V1_larga.wav")
#]

func _ready():
	print("READY MAIN GAME")
	GlobalTiempo.winner.connect(winner)
	if GlobalTuto.tutorial:
		$Ambient.stream=lista_musica_unlocked[0]
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
	
	if GlobalTiempo.diaActual==3:
		$Ambient.stream=lista_musica[1]
		#lista_musica_unlocked.append(lista_musica_to_unlock.pop_front())
	elif GlobalTiempo.diaActual ==5:
		$Ambient.stream=lista_musica[2]
		#lista_musica_unlocked.append(lista_musica_to_unlock.pop_front())
	elif GlobalTiempo.diaActual==7:
		$Ambient.stream=lista_musica[3]
	$Ambient.play(0)
		#lista_musica_unlocked.append(lista_musica_to_unlock.pop_front())
func noSound():
	$Ambient.stop()

func winner():
	# si gana pausa la cancion actual
	$Ambient.stop()
