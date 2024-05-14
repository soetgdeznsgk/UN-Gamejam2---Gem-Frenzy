extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalLogros.primeraChamba.connect(unlock_primerachamba)
	GlobalLogros.tutorialCompleto.connect(unlock_tutorialcompleto)
	GlobalLogros.adoptarGato.connect(unlock_adoptargato)
	
	GlobalLogros.juegoCompleto.connect(unlock_juegocompleto)
	GlobalLogros.reachdia10.connect(unlock_dia10)
	GlobalLogros.reachdia17.connect(unlock_dia17)

func unlock_primerachamba():
	print("primera chamba desbloqueado")
	NG.medal_unlock(78737)
	
func unlock_tutorialcompleto():
	NG.medal_unlock(78738)

func unlock_adoptargato():
	NG.medal_unlock(78739)

func unlock_juegocompleto():
	NG.medal_unlock(78740)

func unlock_dia10():
	NG.medal_unlock(78741)

func unlock_dia17():
	NG.medal_unlock(78742)

