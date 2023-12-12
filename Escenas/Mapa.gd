extends Node2D

var terreno = preload("res://Logica/terreno_solido.tscn")

func _ready() -> void:
	generar_mapa()

func generar_mapa():
	randomize()
	for i in range(0,80):
		for j in range(0,160):
			var temp = terreno.instantiate()
			if GlobalTiempo.diaActual == 1:
				
				temp.position = Vector2(i*8,j*8)
				var porcentaje = randf()
				
				if porcentaje < 0.985 and porcentaje >= 0:
					temp.textura = GlobalRecursos.mineralesConFondo.Tierra
				elif porcentaje > 0.985 and porcentaje < 0.995: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Carbon
				elif porcentaje > 0.995 and porcentaje < 0.998: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Hierro
				elif porcentaje > 0.998 and porcentaje <= 1: 
					temp.textura = GlobalRecursos.mineralesSinFondo.Plata
			
			add_child(temp)
