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
	if GlobalTuto.tutorial:
		#gato bonito
		GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.Gato]=1
		GlobalMejoras.mejora_cambiada.emit()
	else:
		GlobalTiempo.start_time()


# Señales

func playSound():
	pass

		#lista_musica_unlocked.append(lista_musica_to_unlock.pop_front())
func noSound():
	$Ambient.stop()

func winner():
	# si gana pausa la cancion actual
	$Ambient.stop()
