extends Node2D

var terreno = preload("res://Logica/terreno_solido.tscn")

func _ready() -> void:
	generar_mapa()

func generar_mapa():
	randomize()
	for i in range(0,80):
		for j in range(0,160):
			#if GlobalTiempo.diaActual == 
			var temp = terreno.instantiate()
			temp.position = Vector2(i*8,j*8)
			
			var porcentaje = randf()
			if porcentaje < 0.97 and porcentaje >= 0:
				temp.textura = 11
			elif porcentaje > 0.97 and porcentaje < 0.98: 
				temp.textura = 0
			elif porcentaje > 0.98 and porcentaje < 0.99: 
				temp.textura = 1
			elif porcentaje > 0.99 and porcentaje <= 1: 
				temp.textura = 2
			
			add_child(temp)
