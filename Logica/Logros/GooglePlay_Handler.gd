extends Node
var nombreusuario

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayersClient.current_player_loaded.connect(guardar_nombre_jugador)
	iniciar_sesion()
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
func guardar_nombre_jugador(player: PlayersClient):
	nombreusuario=player.display_name
func iniciar_sesion():
	SignInClient.user_authenticated.connect(func(is_authenticated: bool): # (1)
		if not is_authenticated:
			SignInClient.sign_in()
		if is_authenticated:
			PlayersClient.load_current_player(true)
			$TextureRect.visible = false
	)
	
func unlock_primerachamba():
	AchievementsClient.unlock_achievement("CgkIrs_-8_kCEAIQBA")
	
func unlock_tutorialcompleto():
	AchievementsClient.unlock_achievement("CgkIrs_-8_kCEAIQAA")
	#var texture = load("res://Sprites/Logros/tutorialcompletado.png")
	#if !NG.medals[78738].unlocked:
		#NG.medal_unlock(78738)
	#	GlobalLogros.mostrarNotificacion.emit(texture, tr("TUTORIAL_COMPLETO"))
	#if NG.offline_mode:
		#GlobalLogros.mostrarNotificacion.emit(texture, tr("TUTORIAL_COMPLETO"))

func unlock_adoptargato():
	AchievementsClient.unlock_achievement("CgkIrs_-8_kCEAIQBQ")
#desde aca
func unlock_juegocompleto():
	AchievementsClient.unlock_achievement("CgkIrs_-8_kCEAIQCA")

func unlock_dia10():
	AchievementsClient.unlock_achievement("CgkIrs_-8_kCEAIQBw")

func unlock_dia17():
	AchievementsClient.unlock_achievement("CgkIrs_-8_kCEAIQCQ")
func unlock_AllRecipes():
	AchievementsClient.unlock_achievement("CgkIrs_-8_kCEAIQBg")
func unlock_NoUpgrades():
	AchievementsClient.unlock_achievement("CgkIrs_-8_kCEAIQCg")
func unlock_DeliverInTime():
	AchievementsClient.unlock_achievement("CgkIrs_-8_kCEAIQCw")
func unlock_justonemore():
	AchievementsClient.unlock_achievement("CgkIrs_-8_kCEAIQDA")
func unlock_allminerals():
	AchievementsClient.unlock_achievement("CgkIrs_-8_kCEAIQDQ")
func unlock_anticapitalist():
	AchievementsClient.unlock_achievement("CgkIrs_-8_kCEAIQDg")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
