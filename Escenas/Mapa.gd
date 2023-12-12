extends Node2D

var terreno = preload("res://Logica/terreno_solido.tscn")
var matrizTerreno = []


func _ready() -> void:
	generar_mapa()
	GlobalTiempo.finalizarDia.connect(regenerar_mapa)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		GlobalTiempo.tiempoHoraDia += 1


func generar_mapa():
	matrizTerreno.resize(80)
	for i in range(0,80):
		var newMtxJ = []
		newMtxJ.resize(160)
		matrizTerreno[i] = newMtxJ
		for j in range(0,160):
			matrizTerreno[i][j] = 0

	for i in range(0,80):
		for j in range(0,160):
			var temp = terreno.instantiate()
			matrizTerreno[i][j] = temp
			temp.position = Vector2(i*8,j*8)
			$Terrenos.add_child(temp)

func regenerar_mapa():
	randomize()
	for i in range(0,80):
		for j in range(0,160):
			var temp = matrizTerreno[i][j]
			## Hacer acero o venderlo solo
			if GlobalTiempo.diaActual == 1:
				var porcentaje = randf()
				if porcentaje < 0.985 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.990: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Carbon
				elif porcentaje > 0.990 and porcentaje < 0.995: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Hierro
				elif porcentaje > 0.995 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Plata
			
			## Libera all metal
			if GlobalTiempo.diaActual == 2:
				var porcentaje = randf()
				
				if porcentaje < 0.980 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.980 and porcentaje < 0.985: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Carbon
				elif porcentaje > 0.985 and porcentaje < 0.990: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Hierro
				elif porcentaje > 0.990 and porcentaje <= 0.995: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Plata
				elif porcentaje > 0.995 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Cobre
			
			if GlobalTiempo.diaActual == 3:
				var porcentaje = randf()
				
				if porcentaje < 0.985 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.990: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Carbon
				elif porcentaje > 0.990 and porcentaje < 0.993: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Hierro
				elif porcentaje > 0.993 and porcentaje <= 0.996: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Plata
				elif porcentaje > 0.996 and porcentaje <= 0.998: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Cobre
				elif porcentaje > 0.998 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Oro
			
			# Libera receta Fire cristal
			if GlobalTiempo.diaActual == 4:
				var porcentaje = randf()
				
				if porcentaje < 0.825 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.825 and porcentaje < 0.850: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Carbon
				elif porcentaje > 0.85 and porcentaje < 0.875: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Hierro
				elif porcentaje > 0.875 and porcentaje <= 0.9: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Plata
				elif porcentaje > 0.9 and porcentaje <= 0.925: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Cobre
				elif porcentaje > 0.925 and porcentaje <= 0.95: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Rubi
				elif porcentaje > 0.95 and porcentaje <= 0.975: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Topacio
				elif porcentaje > 0.975 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Oro
			# Libera receta ice cristal
			if GlobalTiempo.diaActual == 6:
				var porcentaje = randf()
				
				if porcentaje < 0.725 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.725 and porcentaje < 0.75: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Carbon
				elif porcentaje > 0.75 and porcentaje < 0.775: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Hierro
				elif porcentaje > 0.775 and porcentaje <= 0.8: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Oro
				elif porcentaje > 0.8 and porcentaje <= 0.825: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Cobre
				elif porcentaje > 0.825 and porcentaje <= 0.85: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Rubi
				elif porcentaje > 0.85 and porcentaje <= 0.875: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Topacio
				elif porcentaje > 0.875 and porcentaje <= 0.9: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Zafiro
				elif porcentaje > 0.9 and porcentaje <= 0.925: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Amatista
				elif porcentaje > 0.95 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Plata
			
			# Libera cristal agua
			if GlobalTiempo.diaActual == 7:
				var porcentaje = randf()
				
				if porcentaje < 0.725 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.725 and porcentaje < 0.75: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Carbon
				elif porcentaje > 0.75 and porcentaje < 0.775: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Hierro
				elif porcentaje > 0.775 and porcentaje <= 0.8: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Oro
				elif porcentaje > 0.8 and porcentaje <= 0.825: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Cobre
				elif porcentaje > 0.825 and porcentaje <= 0.85: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Rubi
				elif porcentaje > 0.85 and porcentaje <= 0.875: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Topacio
				elif porcentaje > 0.875 and porcentaje <= 0.9: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Zafiro
				elif porcentaje > 0.9 and porcentaje <= 0.925: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Amatista
				elif porcentaje > 0.95 and porcentaje <= 0.975: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Plata
				elif porcentaje > 0.975 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Diamante
			
			
			# desbloquea todo 3 recetas de golpe.
			if GlobalTiempo.diaActual >= 8:
				var porcentaje = randf()
				
				if porcentaje < 0.7 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.7 and porcentaje < 0.725: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Carbon
				elif porcentaje > 0.725 and porcentaje < 0.75: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Hierro
				elif porcentaje > 0.75 and porcentaje <= 0.775: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Esmeralda
				elif porcentaje > 0.775 and porcentaje <= 0.8: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Cobre
				elif porcentaje > 0.8 and porcentaje <= 0.825: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Rubi
				elif porcentaje > 0.825 and porcentaje <= 0.85: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Topacio
				elif porcentaje > 0.85 and porcentaje <= 0.875: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Zafiro
				elif porcentaje > 0.875 and porcentaje <= 0.9: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Amatista
				elif porcentaje > 0.9 and porcentaje <= 0.925: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Oro
				elif porcentaje > 0.925 and porcentaje <= 0.95: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Diamante
				elif porcentaje > 0.95 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Plata
			temp.actualizar_textura()
