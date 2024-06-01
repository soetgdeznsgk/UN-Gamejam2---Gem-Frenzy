extends Node
#var nombreusuario
var logeadogamejolt=false
var listalogros:Array
var idlogros= [233328,2333330]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameJolt.users_auth_completed.connect(auth_completed)
	GlobalLogros.sendScore.connect(leaderboard_submit)
	GameJolt.trophies_fetch_completed.connect(update_listalogros)
	#PlayersClient.current_player_loaded.connect(guardar_nombre_jugador)
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
	
	pass # Replace with function body.
func leaderboard_submit():
	var diastring= "Day "+str(GlobalTiempo.diaActual)
	GameJolt.scores_add(diastring,GlobalTiempo.diaActual)
#func guardar_nombre_jugador(player: PlayersClient):
#	nombreusuario=player.display_name
func iniciar_sesion(username,gametoken):
	
	GameJolt.set_user_name(username)
	GameJolt.set_user_token(gametoken)
	GameJolt.users_auth()
	return
	#print(GameJolt.get_user_name())
func check_achievement_unlocked(achivementid):
	
	#var arraydelogroculero= [achivementid]
	GameJolt.trophies_fetch()
	await GameJolt.trophies_fetch_completed
	var achieved
	for i in listalogros:
		#print("id buscada ",achivementid," \n",i)
		if achivementid== i["id"]:
			#print("id buscada ",achivementid," \n",i)
			achieved=i["achieved"]
			if i["achieved"]=="false":
				return false
			else:
				return true
		
	
func update_listalogros(response):
	#print(response)
	listalogros=response["trophies"]
func auth_completed(response):
	#print(response["success"])
	logeadogamejolt=response["success"]
func unlock_primerachamba():
	var idlogro="233330"
	var logrodesbloqueado=await check_achievement_unlocked(idlogro)
	#llamar funcion que me diga si está deslboqueado o no 
	var texture = load("res://Sprites/Logros/primerachamba.png")
	#print("logrodesbloqueado ",logrodesbloqueado,"\nnot logro está desbloqueao ",not logrodesbloqueado,"\n logeado en gamejolt ",logeadogamejolt,"\n")
	#print("!logrodesbloqueado and logeadogamejolt -->",!logrodesbloqueado and logeadogamejolt)
	if (not logrodesbloqueado) and logeadogamejolt:
		GameJolt.trophies_add_achieved(idlogro)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("PRIMERA_CHAMBA"))

func unlock_tutorialcompleto():
	var idlogro="233328"
	var logrodesbloqueado=await check_achievement_unlocked(idlogro)
	var texture = load("res://Sprites/Logros/tutorialcompletado.png")
	if !logrodesbloqueado and logeadogamejolt:
		GameJolt.trophies_add_achieved(idlogro)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("TUTORIAL_COMPLETO"))
	#if NG.offline_mode:
	#	GlobalLogros.mostrarNotificacion.emit(texture, tr("TUTORIAL_COMPLETO"))

func unlock_adoptargato():
	var idlogro="233332"
	var logrodesbloqueado=await check_achievement_unlocked(idlogro)
	var texture = load("res://Sprites/Logros/gatoadopatdo.png")
	if !logrodesbloqueado  and logeadogamejolt:
		GameJolt.trophies_add_achieved(idlogro)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("ADOPTAR_GATO"))

func unlock_juegocompleto():
	var idlogro="233338"
	var logrodesbloqueado=await check_achievement_unlocked(idlogro)
	var texture = load("res://Sprites/Logros/ending.png")
	if !logrodesbloqueado  and logeadogamejolt:
		GameJolt.trophies_add_achieved(idlogro)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("JUEGO_COMPLETO"))

func unlock_dia10():
	var idlogro="233339"
	var logrodesbloqueado=await check_achievement_unlocked(idlogro)
	var texture = load("res://Sprites/Logros/day10.png")
	if !logrodesbloqueado  and logeadogamejolt:
		GameJolt.trophies_add_achieved(idlogro)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("DIA_10"))

func unlock_dia17():
	var idlogro="233341"
	var logrodesbloqueado=await check_achievement_unlocked(idlogro)
	var texture = load("res://Sprites/Logros/day17.png")
	if !logrodesbloqueado  and logeadogamejolt:
		GameJolt.trophies_add_achieved(idlogro)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("DIA_17"))
func unlock_AllRecipes():
	var idlogro="233333"
	var logrodesbloqueado=await check_achievement_unlocked(idlogro)
	var texture = load("res://Sprites/Logros/todaslasgemas.png")
	if !logrodesbloqueado  and logeadogamejolt:
		GameJolt.trophies_add_achieved(idlogro)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("ALL_RECIPES"))
func unlock_NoUpgrades():
	var idlogro="233340"
	var logrodesbloqueado=await check_achievement_unlocked(idlogro)
	var texture = load("res://Sprites/Logros/noupgrades.png")
	if !logrodesbloqueado  and logeadogamejolt:
		GameJolt.trophies_add_achieved(idlogro)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("NO_UPGRADES"))
func unlock_DeliverInTime():
	var idlogro="233334"
	var logrodesbloqueado=await check_achievement_unlocked(idlogro)
	var texture = load("res://Sprites/Logros/deliverintime.png")
	if !logrodesbloqueado  and logeadogamejolt:
		GameJolt.trophies_add_achieved(idlogro)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("DELIVER_IN_TIME"))
func unlock_justonemore():
	var idlogro="233335"
	var logrodesbloqueado=await check_achievement_unlocked(idlogro)
	var texture = load("res://Sprites/Logros/justonemore.png")
	if !logrodesbloqueado  and logeadogamejolt:
		GameJolt.trophies_add_achieved(idlogro)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("JUST_ONE_MORE"))
func unlock_allminerals():
	var idlogro="233336"
	var logrodesbloqueado=await check_achievement_unlocked(idlogro)
	var texture = load("res://Sprites/Logros/allminerals.png")
	if !logrodesbloqueado  and logeadogamejolt:
		GameJolt.trophies_add_achieved(idlogro)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("ALL_MINERALS"))
func unlock_anticapitalist():
	var idlogro="233337"
	var logrodesbloqueado=await check_achievement_unlocked(idlogro)
	var texture = load("res://Sprites/Logros/anticapitalist.png")
	#print("anticapitalist desbloqueado?",logrodesbloqueado)
	if (!logrodesbloqueado)  and logeadogamejolt:
		GameJolt.trophies_add_achieved(idlogro)
		GlobalLogros.mostrarNotificacion.emit(texture, tr("ANTICAPITALIST"))
