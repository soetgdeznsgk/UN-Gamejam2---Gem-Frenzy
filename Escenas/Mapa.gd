extends Node2D

var terreno = preload("res://Logica/terreno_solido.tscn")

func _ready() -> void:
	generar_mapa()

func generar_mapa():
	randomize()
	for i in range(0,80):
		for j in range(0,160):
			var temp = terreno.instantiate()
			## Hacer acero o venderlo solo
			if GlobalTiempo.diaActual == 1:
				
				temp.position = Vector2(i*8,j*8)
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
				
				temp.position = Vector2(i*8,j*8)
				var porcentaje = randf()
				
				if porcentaje < 0.985 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.990: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Carbon
				elif porcentaje > 0.990 and porcentaje < 0.9925: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Hierro
				elif porcentaje > 0.9925 and porcentaje <= 0.9950: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Plata
				elif porcentaje > 0.9950 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Cobre
			
			if GlobalTiempo.diaActual == 3:
				
				temp.position = Vector2(i*8,j*8)
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
				
				temp.position = Vector2(i*8,j*8)
				var porcentaje = randf()
				
				if porcentaje < 0.985 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.9988: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Carbon
				elif porcentaje > 0.9988 and porcentaje < 0.9990: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Hierro
				elif porcentaje > 0.9990 and porcentaje <= 0.9992: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Plata
				elif porcentaje > 0.9992 and porcentaje <= 0.9994: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Cobre
				elif porcentaje > 0.9996 and porcentaje <= 0.9998: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Rubi
				elif porcentaje > 0.998 and porcentaje <= 0.999: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Topacio
				elif porcentaje > 0.999 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Oro
			# Libera receta ice cristal
			if GlobalTiempo.diaActual == 6:
				
				temp.position = Vector2(i*8,j*8)
				var porcentaje = randf()
				
				if porcentaje < 0.985 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.9865: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Carbon
				elif porcentaje > 0.9865 and porcentaje < 0.988: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Hierro
				elif porcentaje > 0.988 and porcentaje <= 0.9895: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Oro
				elif porcentaje > 0.9895 and porcentaje <= 0.991: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Cobre
				elif porcentaje > 0.991 and porcentaje <= 0.9925: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Rubi
				elif porcentaje > 0.9925 and porcentaje <= 0.994: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Topacio
				elif porcentaje > 0.994 and porcentaje <= 0.9955: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Safiro
				elif porcentaje > 0.9955 and porcentaje <= 0.997: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Amatista
				elif porcentaje > 0.997 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Plata
			
			# Libera cristal agua
			if GlobalTiempo.diaActual == 7:
				
				temp.position = Vector2(i*8,j*8)
				var porcentaje = randf()
				
				if porcentaje < 0.985 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.98636363636363636363636363636364: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Carbon
				elif porcentaje > 0.98636363636363636363636363636364 and porcentaje < 0.98772727272727272727272727272728: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Hierro
				elif porcentaje > 0.98772727272727272727272727272728 and porcentaje <= 0.98909090909090909090909090909092: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Plata
				elif porcentaje > 0.98909090909090909090909090909092 and porcentaje <= 0.99045454545454545454545454545456: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Cobre
				elif porcentaje > 0.99045454545454545454545454545456 and porcentaje <= 0.9918181818181818181818181818182: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Rubi
				elif porcentaje > 0.9918181818181818181818181818182 and porcentaje <= 0.99318181818181818181818181818184: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Topacio
				elif porcentaje > 0.99318181818181818181818181818184 and porcentaje <= 0.99454545454545454545454545454548: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Safiro
				elif porcentaje > 0.99454545454545454545454545454548 and porcentaje <= 0.99590909090909090909090909090912: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Amatista
				elif porcentaje > 0.99590909090909090909090909090912 and porcentaje <= 0.99727272727272727272727272727276: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Oro
				elif porcentaje > 0.99727272727272727272727272727276 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Diamante
			
			
			# desbloquea todo 3 recetas de golpe.
			if GlobalTiempo.diaActual >= 8:
				
				temp.position = Vector2(i*8,j*8)
				var porcentaje = randf()
				
				if porcentaje < 0.985 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.98625: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Carbon
				elif porcentaje > 0.98625 and porcentaje < 0.9875: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Hierro
				elif porcentaje > 0.9875 and porcentaje <= 0.98875: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Plata
				elif porcentaje > 0.98875 and porcentaje <= 0.99: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Cobre
				elif porcentaje > 0.99 and porcentaje <= 0.99125: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Rubi
				elif porcentaje > 0.99125 and porcentaje <= 0.9925: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Topacio
				elif porcentaje > 0.9925 and porcentaje <= 0.99375: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Safiro
				elif porcentaje > 0.99375 and porcentaje <= 0.995: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Amatista
				elif porcentaje > 0.995 and porcentaje <= 0.99625: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Oro
				elif porcentaje > 0.99625 and porcentaje <= 0.9975: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Diamante
				elif porcentaje > 0.9975 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Esmeralda
				
			add_child(temp)
