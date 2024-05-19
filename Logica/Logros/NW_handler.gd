extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer := Timer.new()
	timer.autostart=true
	timer.wait_time=300
	timer.timeout.connect(ping_a_nw)
	add_child(timer)
	timer.start()
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
		GlobalLogros.DeliverInTime.connect(unlock_DeliverInTime)
		GlobalLogros.justOneMore.connect(unlock_justonemore)
		GlobalLogros.AllMinerals.connect(unlock_allminerals)
		GlobalLogros.Anticapitalist.connect(unlock_anticapitalist)
		
func ping_a_nw():
	NG.components.ping()
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
func unlock_DeliverInTime():
	var texture = load("res://Sprites/Logros/deliverintime.png")
	if !NG.medals[78860].unlocked:
		NG.medal_unlock(78860)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("DELIVER_IN_TIME"))
	if NG.offline_mode:
		GlobalLogros.mostrarNotificacion.emit(texture, tr("DELIVER_IN_TIME"))
func unlock_justonemore():
	var texture = load("res://Sprites/Logros/justonemore.png")
	if !NG.medals[78861].unlocked:
		NG.medal_unlock(78861)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("JUST_ONE_MORE"))
	if NG.offline_mode:
		GlobalLogros.mostrarNotificacion.emit(texture, tr("JUST_ONE_MORE"))
func unlock_allminerals():
	var texture = load("res://Sprites/Logros/allminerals.png")
	if !NG.medals[78862].unlocked:
		NG.medal_unlock(78862)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("ALL_MINERALS"))
	if NG.offline_mode:
		GlobalLogros.mostrarNotificacion.emit(texture, tr("ALL_MINERALS"))
func unlock_anticapitalist():
	var texture = load("res://Sprites/Logros/anticapitalist.png")
	if !NG.medals[78863].unlocked:
		NG.medal_unlock(78863)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("ANTICAPITALIST"))
	if NG.offline_mode:
		GlobalLogros.mostrarNotificacion.emit(texture, tr("ANTICAPITALIST"))
