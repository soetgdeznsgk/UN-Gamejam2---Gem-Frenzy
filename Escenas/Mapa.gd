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
			for j in range(0,11): # Las primeras diez capas de profundidad
				var porcentaje = randf()
				var frame = 0
				if porcentaje < 0.940 and porcentaje >= 0:
					frame = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.935 and porcentaje < 0.975: 
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
			for j in range(10,21): # Las segundas 10 capas de profundidad
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
		Cam.limit_bottom = 184
		barraBloqueoDias.position.y = 184
		
	# se vende el oro solito
	if GlobalTiempo.diaActual >= 3:
		for i in range(0,79):
			for j in range(20,31):
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
		Cam.limit_bottom = 264
		barraBloqueoDias.position.y = 264
	
	# Libera receta Fire cristal
	if GlobalTiempo.diaActual >= 4:
		for i in range(0,79):
			for j in range(30,51):
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
		Cam.limit_bottom = 424
		barraBloqueoDias.position.y = 424
		
	# Libera receta ice cristal
	if GlobalTiempo.diaActual >= 6:
		for i in range(0,79):
			for j in range(50,81):
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
		Cam.limit_bottom = 664
		barraBloqueoDias.position.y = 664
	
	# Libera cristal de tierra
	# Libera RGB cristal
	if GlobalTiempo.diaActual >= 7:
		for i in range(0,79):
			for j in range(80,111):
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
		Cam.limit_bottom = 904
		barraBloqueoDias.position.y = 904
	
	# desbloquea 3 recetas de golpe.
	if GlobalTiempo.diaActual >= 8:
		for i in range(0,79):
			for j in range(110,141):
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
		Cam.limit_bottom = 1144
		barraBloqueoDias.position.y = 1144
	
	if GlobalTiempo.diaActual >= 9:
		for i in range(0,79):
			for j in range(140,171):
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
