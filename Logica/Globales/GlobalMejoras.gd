extends Node

# Este singleton contiene las mejoras activas y las posibles mejoras a ganar
signal mejora_cambiada
var mejora_final_comprada
enum nombre_mejoras {
	CofreMineral,
	MejoraDeMejoras,
	MasReciclaje,
	ClientesZen,
	MasTiempo,
	PanchaSpeedUp,
	RecompensaMejorada,
	Gato,
}
var mejora_final = {
	"ContratoFinal": {
		"Key" : "ContratoFinal",
		"Nombre" : tr("CONTRACT"),
		"Precio" : 10,
		"PrecioEscalar" : 0,
		"Maximo" : 1,
		"Textura" : 'res://Sprites/mejoras/contrato.png',
		"Descripcion" : tr("CONTRACT_DESC"),
	}}
func llenar_mejora_final():
	mejora_final = {
	"ContratoFinal": {
		"Key" : "ContratoFinal",
		"Nombre" : tr("CONTRACT"),
		"Precio" : 10,
		"PrecioEscalar" : 0,
		"Maximo" : 1,
		"Textura" : 'res://Sprites/mejoras/contrato.png',
		"Descripcion" : tr("CONTRACT_DESC"),
	}}
var info_mejoras = {}

func llenar_mejoras() -> void:
	info_mejoras = {
	nombre_mejoras.CofreMineral : { # que aumente de a 2 por mejora
		"Key" : nombre_mejoras.CofreMineral,
		"Nombre" : tr("CHEST"),
		"Precio" : 2,
		"PrecioEscalar" : 2,
		"Maximo" : 4,
		"Textura" : 'res://Sprites/mejoras/cofre con marco.png',
		"Descripcion" : tr("CHEST_DESC"),
	},
		nombre_mejoras.MejoraDeMejoras : {
		"Key" : nombre_mejoras.MejoraDeMejoras,
		"Nombre" : tr("MANY_UPGRADES"),
		"PrecioEscalar" : 1,
		"Precio" : 5,
		"Maximo" : 1,
		"Textura" : 'res://Sprites/mejoras/mejora de mejoras.png',
		"Descripcion" : tr("MANY_UPGRADES_DESC"),
	},
	nombre_mejoras.ClientesZen : { # implementada en Order.gd
		"Key" : nombre_mejoras.ClientesZen,
		"Nombre" : tr("ZEN_CLIENTS"),
		"Precio" : 6,
		"PrecioEscalar" : 3,
		"Maximo" : 2,
		"Textura" : 'res://Sprites/mejoras/Mejora zen.png',
		"Descripcion" : tr("ZEN_CLIENTS_DESC"),
	},
	nombre_mejoras.MasTiempo : {
		"Key" : nombre_mejoras.MasTiempo,
		"Nombre" : tr("MORE_TIME"),
		"Precio" : 5,
		"PrecioEscalar" : 12,
		"Maximo" : 3,
		"Textura" : 'res://Sprites/mejoras/reloj mejorado.png',
		"Descripcion" : tr("MORE_TIME_DESC"),
	},
	nombre_mejoras.MasReciclaje : {
		"Key" : nombre_mejoras.MasReciclaje,
		"Nombre" : tr("RECYCLE"),
		"PrecioEscalar" : 12,
		"Precio" : 6,
		"Maximo" : 2,
		"Textura" : 'res://Sprites/mejoras/RECYCLE.png',
		"Descripcion" : tr("RECYCLE_DESC"),
	},
	nombre_mejoras.PanchaSpeedUp : { # implementada en pancha speed
		"Key" : nombre_mejoras.PanchaSpeedUp,
		"Nombre" : tr("SPEED_UP"),
		"Precio" : 10,
		"PrecioEscalar" : 14,
		"Maximo" : 2,
		"Textura" : 'res://Sprites/mejoras/pancha_speed.png',
		"Descripcion" : tr("SPEED_UP_DESC"),
	},
		nombre_mejoras.RecompensaMejorada : { # implementada en OrderManager.gd
		"Key" : nombre_mejoras.RecompensaMejorada,
		"Nombre" : tr("MORE_PROFITS"),
		"Precio" : 7,
		"PrecioEscalar" : 11,
		"Maximo" : 3,
		"Textura" : 'res://Sprites/mejoras/monedaMejorada.png',
		"Descripcion" : tr("MORE_PROFITS_DESC"),
	},
		nombre_mejoras.Gato : { # implementada en GeneradorClientes.gd
		"Key" : nombre_mejoras.Gato,
		"Nombre" : tr("CATO"),
		"Precio" : 13,
		"PrecioEscalar" : 13,
		"Maximo" : 2,
		"Textura" : 'res://Sprites/mejoras/gatomejora.png',
		"Descripcion" : tr("CATO_DESC"),
	},
}

var disponible_mejoras = []
var activas_mejoras = []

# TEST para noestar comprando mejoras
func test_final():
	for i in range(0,nombre_mejoras.size()):
		disponible_mejoras[i] = 0
		activas_mejoras[i] = info_mejoras[i]["Maximo"]

func reiniciar_mejoras() -> void:
	for i in range(0,nombre_mejoras.size()):
		disponible_mejoras[i] = info_mejoras[i]["Maximo"]
		activas_mejoras[i] = 0

func _ready() -> void:
	llenar_mejoras()
	disponible_mejoras = []
	activas_mejoras = []
	for i in range(0,nombre_mejoras.size()):
		disponible_mejoras.append(info_mejoras[i]["Maximo"])
		activas_mejoras.append(0)
	#test_final()

func obtener_mejora_random_disponible():
	#verifica en las disponibles y devuelve alguna al azar
	var posibles_mejoras : Array = []
	var mejoras_seleccionadas : Array = []
	
	#si no se ha terminado de mejorar los cofres, se fuerza su aparicion
	#if disponible_mejoras[nombre_mejoras.CofreMineral]>0:
		#mejoras_seleccionadas.append(info_mejoras[nombre_mejoras.CofreMineral])
	# lo mismo con mejora de mejoras
	#if disponible_mejoras[nombre_mejoras.MejoraDeMejoras]>0:
		#mejoras_seleccionadas.append(info_mejoras[nombre_mejoras.MejoraDeMejoras])
	# Añade a la pool mejoras disponibles
	for i in range(0, len(nombre_mejoras)):
		if disponible_mejoras[i] > 0:
			posibles_mejoras.append(i)
	# Elije las mejoras de la pool
	if len(posibles_mejoras) > 0:
		# selecciona 2 + mejora de mejoras
		for i in range(0, 2 + activas_mejoras[nombre_mejoras.MejoraDeMejoras]):
			var selec : int
			var porcentaje = randf()
			
			if len(posibles_mejoras) >= 6:
				if porcentaje < 0.5:
					selec = 0
				if porcentaje > 0.5 and porcentaje < 0.75:
					selec = 1
				if porcentaje > 0.75 and porcentaje < 0.9:
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
		if GlobalTiempo.diaActual>=9 and mejoras_seleccionadas.size()<=2:		
			mejoras_seleccionadas.append(mejora_final["ContratoFinal"])
		return mejoras_seleccionadas
	else:
		var listafinal=[]
		
		listafinal.append(mejora_final["ContratoFinal"])
		
		# dice que no hay ninguna
		return listafinal
