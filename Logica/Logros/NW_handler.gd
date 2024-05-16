extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Si es NG pero no hay cuenta, igual salen logros pero sin verificar si son replicados
	print("NG OFFLINE? " ,NG.offline_mode)
	# Solo hace cosas si es la api que esperamos
	if GlobalLogros.APIHandler == "NEWGROUNDS":
		GlobalLogros.primeraChamba.connect(unlock_primerachamba)
		GlobalLogros.tutorialCompleto.connect(unlock_tutorialcompleto)
		GlobalLogros.adoptarGato.connect(unlock_adoptargato)
		GlobalLogros.juegoCompleto.connect(unlock_juegocompleto)
		GlobalLogros.reachdia10.connect(unlock_dia10)
		GlobalLogros.reachdia17.connect(unlock_dia17)
		GlobalLogros.AllRecipes.connect(unlock_AllRecipes)
		GlobalLogros.NoUpgrades.connect(unlock_NoUpgrades)
func unlock_primerachamba():
	var texture = load("res://Sprites/Logros/primerachamba.png")
	if !NG.medals[78737].unlocked:
		NG.medal_unlock(78737)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("PRIMERA_CHAMBA"))
	if NG.offline_mode:
		GlobalLogros.mostrarNotificacion.emit(texture, tr("PRIMERA_CHAMBA"))

func unlock_tutorialcompleto():
	var texture = load("res://Sprites/Logros/tutorialcompletado.png")
	if !NG.medals[78738].unlocked:
		NG.medal_unlock(78738)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("TUTORIAL_COMPLETO"))
	if NG.offline_mode:
		GlobalLogros.mostrarNotificacion.emit(texture, tr("TUTORIAL_COMPLETO"))

func unlock_adoptargato():
	var texture = load("res://Sprites/Logros/gatoadopatdo.png")
	if !NG.medals[78739].unlocked:
		NG.medal_unlock(78739)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("ADOPTAR_GATO"))
	if NG.offline_mode:
		GlobalLogros.mostrarNotificacion.emit(texture, tr("ADOPTAR_GATO"))

func unlock_juegocompleto():
	var texture = load("res://Sprites/Logros/ending.png")
	if !NG.medals[78740].unlocked:
		NG.medal_unlock(78740)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("JUEGO_COMPLETO"))
	if NG.offline_mode:
		GlobalLogros.mostrarNotificacion.emit(texture, tr("JUEGO_COMPLETO"))

func unlock_dia10():
	var texture = load("res://Sprites/Logros/day10.png")
	if !NG.medals[78741].unlocked:
		NG.medal_unlock(78741)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("DIA_10"))
	if NG.offline_mode:
		GlobalLogros.mostrarNotificacion.emit(texture, tr("DIA_10"))

func unlock_dia17():
	var texture = load("res://Sprites/Logros/day17.png")
	if !NG.medals[78742].unlocked:
		NG.medal_unlock(78742)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("DIA_17"))
	if NG.offline_mode:
		GlobalLogros.mostrarNotificacion.emit(texture, tr("DIA_17"))
func unlock_AllRecipes():
	var texture = load("res://Sprites/Logros/todaslasgemas.png")
	if !NG.medals[78850].unlocked:
		NG.medal_unlock(78850)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("ALL_RECIPES"))
	if NG.offline_mode:
		GlobalLogros.mostrarNotificacion.emit(texture, tr("ALL_RECIPES"))
func unlock_NoUpgrades():
	var texture = load("res://Sprites/Logros/noupgrades.png")
	if !NG.medals[78849].unlocked:
		NG.medal_unlock(78849)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("NO_UPGRADES"))
	if NG.offline_mode:
		GlobalLogros.mostrarNotificacion.emit(texture, tr("NO_UPGRADES"))
