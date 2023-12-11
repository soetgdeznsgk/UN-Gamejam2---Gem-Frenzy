extends Node

# Este singleton contiene las mejoras activas y las posibles mejoras a ganar

enum nombre_mejoras {
	Mochila,
	CofreMineral,
	Gato,
	MejoraDeMejoras,
	RecompensaMejorada,
	ClientesZen,
	MasTiempo,
}

var info_mejoras = {
	nombre_mejoras.Mochila : {
		"Key" : nombre_mejoras.Mochila,
		"Nombre" : "Mochila grande",
		"Precio" : 5,
		"Maximo" : 3,
		"Textura" : 'null',
		"Descripcion" : "Permite llevar más minerales",
	},
	nombre_mejoras.CofreMineral : {
		"Key" : nombre_mejoras.CofreMineral,
		"Nombre" : "Cofre",
		"Precio" : 2,
		"Maximo" : 8,
		"Textura" : 'null',
		"Descripcion" : "Permite almacenar más tipos de minerales",
	},
	nombre_mejoras.Gato : {
		"Key" : nombre_mejoras.Gato,
		"Nombre" : "Gato",
		"Precio" : 10,
		"Maximo" : 2,
		"Textura" : 'null',
		"Descripcion" : "Un gato siempre atrae más clientes!",
	},
	nombre_mejoras.MejoraDeMejoras : {
		"Key" : nombre_mejoras.MejoraDeMejoras,
		"Nombre" : "Muchas mejoras",
		"Precio" : 10,
		"Maximo" : 1,
		"Textura" : 'null',
		"Descripcion" : "No son suficientes mejoras? Agrega una más al finalizar el dia",
	},
	nombre_mejoras.RecompensaMejorada : {
		"Key" : nombre_mejoras.RecompensaMejorada,
		"Nombre" : "Recompensas!",
		"Precio" : 4,
		"Maximo" : 3,
		"Textura" : 'null',
		"Descripcion" : "Cobra más por tu trabajo!",
	},
	nombre_mejoras.ClientesZen : {
		"Key" : nombre_mejoras.ClientesZen,
		"Nombre" : "Clientes Zen",
		"Precio" : 3,
		"Maximo" : 3,
		"Textura" : 'null',
		"Descripcion" : "Gracias a la meditación los clientes esperan más tiempo",
	},
	nombre_mejoras.MasTiempo : {
		"Key" : nombre_mejoras.MasTiempo,
		"Nombre" : "Mas tiempo",
		"Precio" : 3,
		"Maximo" : 7,
		"Textura" : 'null',
		"Descripcion" : "Tu tienda esta abierta mas horas",
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
	for i in range(len(nombre_mejoras)):
		if disponible_mejoras[i] > 0:
			posibles_mejoras.append(i)
	if len(posibles_mejoras) > 0:
		# selecciona algunas entre las que hay
		# selecciona 2 + mejora de mejoras
		var mejoras_seleccionadas : Array = []
		for i in range(0, 2 + activas_mejoras[nombre_mejoras.MejoraDeMejoras]):
			var selec = randi_range(0,len(posibles_mejoras)-1)
			posibles_mejoras.pop_at(selec)
			mejoras_seleccionadas.append(info_mejoras[selec])
		return mejoras_seleccionadas
	else:
		# dice que no hay ninguna
		return []
		