extends Node2D
var matrizTerreno = []
@onready var barraBloqueoDias = %BLOQUEADIAS
@onready var Cam = %CamPlayer
@onready var terreno = $Terreno
func _ready() -> void:
	GlobalTiempo.iniciarDia.connect(regenerar_mapa)
	GlobalTiempo.tmr_minuto.start()
	regenerar_mapa()
	GlobalRecursos.actualizar_renta()

func regenerar_mapa():
	# J es profundidad y I es anchura
	randomize()
	# Hacer acero o venderlo solo
	if GlobalTiempo.diaActual >= 1: 
		for i in range(0,79):
			for j in range(0,13): # Las primeras diez capas de profundidad
				var porcentaje = randf()
				var frame = 0
				if porcentaje < 0.940 and porcentaje >= 0:
					frame = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.940 and porcentaje < 0.975: 
					frame = GlobalRecursos.mineralesConFondo.Carbon
				elif porcentaje > 0.975 and porcentaje < 0.99: 
					frame = GlobalRecursos.mineralesConFondo.Hierro
				elif porcentaje > 0.99 and porcentaje <= 1: 
					frame = GlobalRecursos.mineralesConFondo.Plata
				@warning_ignore("integer_division")
				var atlasCordsY = floori(frame / 6)
				var atlasCordsX = frame % 6
				var atlasCords = Vector2(atlasCordsX, atlasCordsY)
				terreno.set_cell(0,Vector2(i,j),1,atlasCords)
		Cam.limit_bottom = 104
		barraBloqueoDias.position.y = 104
	
	## Libera all metal
	if GlobalTiempo.diaActual >= 2:
		for i in range(0,79):
			for j in range(10,20): # Las segundas 10 capas de profundidad
				var porcentaje = randf()
				var frame = 0
				if porcentaje < 0.955 and porcentaje >= 0:
					frame = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.955 and porcentaje <= 0.975: 
					frame = GlobalRecursos.mineralesConFondo.Plata
				elif porcentaje > 0.975 and porcentaje <= 0.985: 
					frame = GlobalRecursos.mineralesConFondo.Hierro
				elif porcentaje > 0.985 and porcentaje <= 1: 
					frame = GlobalRecursos.mineralesConFondo.Cobre
				@warning_ignore("integer_division")
				var atlasCordsY = floori(frame / 6)
				var atlasCordsX = frame % 6
				var atlasCords = Vector2(atlasCordsX, atlasCordsY)
				terreno.set_cell(0,Vector2(i,j),1,atlasCords)
		Cam.limit_bottom = 180
		barraBloqueoDias.position.y = 180
		
	# se vende el oro solito
	if GlobalTiempo.diaActual >= 3:
		for i in range(0,79):
			for j in range(20,40):
				var porcentaje = randf()
				var frame = 0
				if porcentaje < 0.97 and porcentaje >= 0:
					frame = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.97 and porcentaje <= 0.988: 
					frame = GlobalRecursos.mineralesConFondo.Cobre
				elif porcentaje > 0.988 and porcentaje <= 1: 
					frame = GlobalRecursos.mineralesConFondo.Oro
				@warning_ignore("integer_division")
				var atlasCordsY = floori(frame / 6)
				var atlasCordsX = frame % 6
				var atlasCords = Vector2(atlasCordsX, atlasCordsY)
				terreno.set_cell(0,Vector2(i,j),1,atlasCords)
		Cam.limit_bottom = 340
		barraBloqueoDias.position.y = 340
	
	# Libera receta Fire cristal
	if GlobalTiempo.diaActual >= 4:
		for i in range(0,79):
			for j in range(40,60):
				var porcentaje = randf()
				var frame = 0
				if porcentaje < 0.975 and porcentaje >= 0:
					frame = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.975 and porcentaje < 0.985:
					frame = GlobalRecursos.mineralesConFondo.Rubi
				elif porcentaje > 0.985 and porcentaje <= 0.995: 
					frame = GlobalRecursos.mineralesConFondo.Topacio
				elif porcentaje > 0.995 and porcentaje <= 1: 
					frame = GlobalRecursos.mineralesConFondo.Oro
				
				@warning_ignore("integer_division")
				var atlasCordsY = floori(frame / 6)
				var atlasCordsX = frame % 6
				var atlasCords = Vector2(atlasCordsX, atlasCordsY)
				terreno.set_cell(0,Vector2(i,j),1,atlasCords)
		Cam.limit_bottom = 500
		barraBloqueoDias.position.y = 500
		
	# Libera receta ice cristal
	if GlobalTiempo.diaActual >= 6:
		for i in range(0,79):
			for j in range(60,90):
				var porcentaje = randf()
				var frame = 0
				if porcentaje < 0.985 and porcentaje >= 0:
					frame = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.995:
					frame = GlobalRecursos.mineralesConFondo.Zafiro
				elif porcentaje > 0.995 and porcentaje <= 1: 
					frame = GlobalRecursos.mineralesConFondo.Amatista
				@warning_ignore("integer_division")
				var atlasCordsY = floori(frame / 6)
				var atlasCordsX = frame % 6
				var atlasCords = Vector2(atlasCordsX, atlasCordsY)
				terreno.set_cell(0,Vector2(i,j),1,atlasCords)
		Cam.limit_bottom = 740
		barraBloqueoDias.position.y = 740
	
	# Libera cristal de tierra
	# Libera RGB cristal
	if GlobalTiempo.diaActual >= 7:
		for i in range(0,79):
			for j in range(90,120):
				var porcentaje = randf()
				var frame = 0
				if porcentaje < 0.985 and porcentaje >= 0:
					frame = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.995:
					frame = GlobalRecursos.mineralesConFondo.Amatista
				elif porcentaje > 0.995 and porcentaje <= 1: 
					frame = GlobalRecursos.mineralesConFondo.Esmeralda
				@warning_ignore("integer_division")
				var atlasCordsY = floori(frame / 6)
				var atlasCordsX = frame % 6
				var atlasCords = Vector2(atlasCordsX, atlasCordsY)
				terreno.set_cell(0,Vector2(i,j),1,atlasCords)
		Cam.limit_bottom = 980
		barraBloqueoDias.position.y = 980
	
	# desbloquea 3 recetas de golpe.
	if GlobalTiempo.diaActual >= 8:
		for i in range(0,79):
			for j in range(120,150):
				var porcentaje = randf()
				var frame = 0
				if porcentaje < 0.985 and porcentaje >= 0:
					frame = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.995:
					frame = GlobalRecursos.mineralesConFondo.Esmeralda
				elif porcentaje > 0.995 and porcentaje <= 1: 
					frame = GlobalRecursos.mineralesConFondo.Diamante
				@warning_ignore("integer_division")
				var atlasCordsY = floori(frame / 6)
				var atlasCordsX = frame % 6
				var atlasCords = Vector2(atlasCordsX, atlasCordsY)
				terreno.set_cell(0,Vector2(i,j),1,atlasCords)
		Cam.limit_bottom = 1180
		barraBloqueoDias.position.y = 1180
	
	if GlobalTiempo.diaActual >= 9:
		for i in range(0,79):
			for j in range(150,160):
				var porcentaje = randf()
				var frame = 0
				if porcentaje < 0.98 and porcentaje >= 0:
					frame = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.98 and porcentaje < 0.99:
					frame = GlobalRecursos.mineralesConFondo.Diamante
				elif porcentaje > 0.99 and porcentaje <= 1: 
					frame = GlobalRecursos.mineralesConFondo.Esmeralda
				@warning_ignore("integer_division")
				var atlasCordsY = floori(frame / 6)
				var atlasCordsX = frame % 6
				var atlasCords = Vector2(atlasCordsX, atlasCordsY)
				terreno.set_cell(0,Vector2(i,j),1,atlasCords)
		Cam.limit_bottom = 1276
		barraBloqueoDias.position.y = 1276
