extends Node

# Este singleton contiene las mejoras activas y las posibles mejoras a ganar
signal mejora_cambiada

enum nombre_mejoras {
	CofreMineral,
	MejoraDeMejoras,
	ClientesZen,
	MasTiempo,
	RecompensaMejorada,
	Gato,
}

var info_mejoras = {
	nombre_mejoras.CofreMineral : { # que aumente de a 2 por mejora
		"Key" : nombre_mejoras.CofreMineral,
		"Nombre" : "Cofre",
		"Precio" : 2,
		"Maximo" : 4,
		"Textura" : 'res://Sprites/mejoras/cofre con marco.png',
		"Descripcion" : "Permite almacenar más tipos de minerales",
	},
		nombre_mejoras.MejoraDeMejoras : {
		"Key" : nombre_mejoras.MejoraDeMejoras,
		"Nombre" : "Muchas mejoras",
		"Precio" : 5,
		"Maximo" : 1,
		"Textura" : 'res://Sprites/mejoras/mejora de mejoras.png',
		"Descripcion" : "No son suficientes mejoras? Agrega una más al finalizar el dia",
	},
	nombre_mejoras.ClientesZen : { # implementada en Order.gd
		"Key" : nombre_mejoras.ClientesZen,
		"Nombre" : "Clientes Zen",
		"Precio" : 6,
		"Maximo" : 2,
		"Textura" : 'res://Sprites/mejoras/Mejora zen.png',
		"Descripcion" : "Gracias a la meditación los clientes esperan más tiempo",
	},
	nombre_mejoras.MasTiempo : {
		"Key" : nombre_mejoras.MasTiempo,
		"Nombre" : "Mas tiempo",
		"Precio" : 10,
		"Maximo" : 2,
		"Textura" : 'res://Sprites/mejoras/reloj mejorado.png',
		"Descripcion" : "Tu tienda estará abierta mas horas",
	},
		nombre_mejoras.RecompensaMejorada : { # implementada en OrderManager.gd
		"Key" : nombre_mejoras.RecompensaMejorada,
		"Nombre" : "Cobra mas!",
		"Precio" : 13,
		"Maximo" : 2,
		"Textura" : 'res://Sprites/mejoras/monedaMejorada.png',
		"Descripcion" : "Cobra más por tu trabajo!",
	},
		nombre_mejoras.Gato : { # implementada en GeneradorClientes.gd
		"Key" : nombre_mejoras.Gato,
		"Nombre" : "Gato",
		"Precio" : 16,
		"Maximo" : 2,
		"Textura" : 'res://Sprites/mejoras/gatomejora.png',
		"Descripcion" : "Un gato siempre atrae más clientes!",
	},
}
var disponible_mejoras = [0,0,0,0,0,0,0]
var activas_mejoras = [0,0,0,0,0,0,0]

func _ready() -> void:
	for i in range(len(nombre_mejoras)):
		disponible_mejoras[i] = info_mejoras[i]["Maximo"]

func obtener_mejora_random_disponible():
	#verifica en las disponibles y devuelve alguna al azar
	var posibles_mejoras : Array = []
	var mejoras_seleccionadas : Array = []
	
	#si no se ha terminado de mejorar los cofres, se fuerza su aparicion
	if disponible_mejoras[0]>0:
		mejoras_seleccionadas.append(info_mejoras[0])
	
	for i in range(1, len(nombre_mejoras)):
		if disponible_mejoras[i] > 0:
			posibles_mejoras.append(i)
	if len(posibles_mejoras) > 0:
		# selecciona algunas entre las que hay
		# selecciona 2 + mejora de mejoras
		for i in range(len(mejoras_seleccionadas), 2 + activas_mejoras[nombre_mejoras.MejoraDeMejoras]):
			var selec : int
			var porcentaje = randf()
			
			if len(posibles_mejoras) == 6:
				if porcentaje < 0.65:
					selec = 0
				if porcentaje > 0.65 and porcentaje < 0.85:
					selec = 1
				if porcentaje > 0.85 and porcentaje < 0.9:
					selec = 2
				if porcentaje > 0.9 and porcentaje < 0.95:
					selec = 3
				if porcentaje > 0.95 and porcentaje < 0.99:
					selec = 4
				if porcentaje > 0.99 and porcentaje <= 1.0:
					selec = 5
			elif len(posibles_mejoras) == 5:
				if porcentaje < 0.65:
					selec = 0
				if porcentaje > 0.65 and porcentaje < 0.85:
					selec = 1
				if porcentaje > 0.85 and porcentaje < 0.9:
					selec = 2
				if porcentaje > 0.9 and porcentaje < 0.95:
					selec = 3
				if porcentaje > 0.95:
					selec = 4
				
			elif len(posibles_mejoras) == 4:
				if porcentaje < 0.65:
					selec = 0
				if porcentaje > 0.65 and porcentaje < 0.9:
					selec = 1
				if porcentaje > 0.9 and porcentaje < 0.95:
					selec = 2
				if porcentaje > 0.95:
					selec = 3
			
			elif len(posibles_mejoras) == 3:
				if porcentaje < 0.4:
					selec = 0
				if porcentaje > 0.4 and porcentaje < 0.8:
					selec = 1
				if porcentaje > 0.8:
					selec = 2
			
			elif len(posibles_mejoras) == 2:
				if porcentaje < 0.5:
					selec = 0
				if porcentaje > 0.5:
					selec = 1
			
			elif len(posibles_mejoras) == 1:
				selec = 0
			
			var mejora = posibles_mejoras.pop_at(selec)
			if mejora != null:
				mejoras_seleccionadas.append(info_mejoras[mejora])
		return mejoras_seleccionadas
	else:
		# dice que no hay ninguna
		return []
		
