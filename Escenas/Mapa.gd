extends Node2D

var terreno = preload("res://Logica/terreno_solido.tscn")
var matrizTerreno = []
@onready var barraBloqueoDias = %BLOQUEADIAS
@onready var Cam = %CamPlayer
func _ready() -> void:
	generar_mapa()
	GlobalTiempo.iniciarDia.connect(regenerar_mapa)
	GlobalTiempo.tmr_minuto.start()
	regenerar_mapa()

func _process(_delta: float) -> void:
	# ESTO ES SOLO PARA DEBUG NO MAS
	if Input.is_action_just_pressed("ui_accept"):
		GlobalTiempo.tiempoHoraDia += 1
		print('avanza hora dbug')


func generar_mapa():
	#crea una matriz y la llena de ceros para usarla despues
	matrizTerreno.resize(80)
	for i in range(0,80):
		var newMtxJ = []
		newMtxJ.resize(160)
		matrizTerreno[i] = newMtxJ
		for j in range(0,160):
			matrizTerreno[i][j] = 0
	# Rellena la matriz con los terrenos creados para reussarlos despues en regenerar mapa
	for i in range(0,80):
		for j in range(0,160):
			var temp = terreno.instantiate()
			matrizTerreno[i][j] = temp
			temp.position = Vector2(i*8,j*8)
			$Terrenos.add_child(temp)

func regenerar_mapa():
	# J es profundidad y I es anchura
	randomize()
	## Hacer acero o venderlo solo
	if GlobalTiempo.diaActual >= 1: 
		for i in range(0,80):
			for j in range(0,10): # Las primeras diez capas de profundidad
				var porcentaje = randf()
				var temp = matrizTerreno[i][j]
				if porcentaje < 0.96 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.96 and porcentaje < 0.98: 
					temp.textura = GlobalRecursos.mineralesConFondo.Carbon
				elif porcentaje > 0.98 and porcentaje < 0.99: 
					temp.textura = GlobalRecursos.mineralesConFondo.Hierro
				elif porcentaje > 0.99 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesConFondo.Plata
				temp.actualizar_textura()
		Cam.limit_bottom = 100
		barraBloqueoDias.position.y = 100
	
	## Libera all metal
	if GlobalTiempo.diaActual >= 2:
		for i in range(0,80):
			for j in range(10,20): # Las segundas 10 capas de profundidad
				var porcentaje = randf()
				var temp = matrizTerreno[i][j]
				if porcentaje < 0.975 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.975 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesConFondo.Cobre
				temp.actualizar_textura()
		Cam.limit_bottom = 260
		barraBloqueoDias.position.y = 260
		
	# se vende el oro solito
	if GlobalTiempo.diaActual >= 3:
		for i in range(0,80):
			for j in range(20,40):
				var porcentaje = randf()
				var temp = matrizTerreno[i][j]
				if porcentaje < 0.975 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.975 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesConFondo.Oro
				temp.actualizar_textura()
		Cam.limit_bottom =420
		barraBloqueoDias.position.y = 420
	
	# Libera receta Fire cristal
	if GlobalTiempo.diaActual >= 4:
		for i in range(0,80):
			for j in range(40,60):
				var porcentaje = randf()
				var temp = matrizTerreno[i][j]
				if porcentaje < 0.975 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.995:
					temp.textura = GlobalRecursos.mineralesConFondo.Rubi
				elif porcentaje > 0.995 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesConFondo.Topacio
				temp.actualizar_textura()
		Cam.limit_bottom = 580
		barraBloqueoDias.position.y = 580
		
	# Libera receta ice cristal
	if GlobalTiempo.diaActual >= 6:
		for i in range(0,80):
			for j in range(60,90):
				var porcentaje = randf()
				var temp = matrizTerreno[i][j]
				if porcentaje < 0.975 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.995:
					temp.textura = GlobalRecursos.mineralesConFondo.Zafiro
				elif porcentaje > 0.995 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesConFondo.Amatista
				temp.actualizar_textura()
		Cam.limit_bottom = 820
		barraBloqueoDias.position.y = 820
	
	# Libera cristal de tierra
	# Libera RGB cristal
	if GlobalTiempo.diaActual >= 7:
		for i in range(0,80):
			for j in range(90,120):
				var porcentaje = randf()
				var temp = matrizTerreno[i][j]
				if porcentaje < 0.975 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.995:
					temp.textura = GlobalRecursos.mineralesConFondo.Carbon
				elif porcentaje > 0.995 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesConFondo.Esmeralda
				temp.actualizar_textura()
		Cam.limit_bottom = 1060
		barraBloqueoDias.position.y = 1060
	
	# desbloquea todo 3 recetas de golpe.
	if GlobalTiempo.diaActual >= 8:
		for i in range(0,80):
			for j in range(90,120):
				var porcentaje = randf()
				var temp = matrizTerreno[i][j]
				if porcentaje < 0.975 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.995:
					temp.textura = GlobalRecursos.mineralesConFondo.Amatista
				elif porcentaje > 0.995 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesConFondo.Diamante
				temp.actualizar_textura()
		Cam.limit_bottom = 1300
		barraBloqueoDias.position.y = 1300
## Quedan libres 30 niveles de profundidad pa saber
