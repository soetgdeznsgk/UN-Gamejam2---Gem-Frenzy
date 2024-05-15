extends Node

@warning_ignore("unused_signal")
signal primeraChamba
@warning_ignore("unused_signal")
signal tutorialCompleto
@warning_ignore("unused_signal")
signal adoptarGato
@warning_ignore("unused_signal")
signal juegoCompleto
@warning_ignore("unused_signal")
signal reachdia10
@warning_ignore("unused_signal")
signal reachdia17
@warning_ignore("unused_signal")
signal mostrarNotificacion(tex,titulo)

signal AllRecipes #falta agregar entrada a nw y conectar a nw_handler
signal NoUpgrades #falta agregar entrada a nw y conectar a nw_handler ytestear

var copiaRecetas = GlobalRecetas.recetas.duplicate()
var APIHandler = "NEWGROUNDS"


func _ready() -> void:
	GlobalTiempo.iniciarDia.connect(check_logros_al_iniciar)
	print(copiaRecetas)

func check_logros_al_iniciar():
	# verifica que todas las mejoras esten en 0 (le aplica la funcion a cada elemento del array)
	if GlobalTiempo.diaActual==7 and GlobalMejoras.activas_mejoras.all(equal_to_zero):
		NoUpgrades.emit()
	if GlobalTiempo.diaActual==10:
		GlobalLogros.reachdia10.emit()
	if GlobalTiempo.diaActual==17:
		GlobalLogros.reachdia17.emit()

func equal_to_zero(number):
	return number==0

func check_AllRecipes(receta):
	if !copiaRecetas.is_empty():
		copiaRecetas.erase(GlobalRecetas.recetas.keys()[receta])
	elif copiaRecetas.is_empty():
		AllRecipes.emit()
		print("copia recetas",copiaRecetas)
	
