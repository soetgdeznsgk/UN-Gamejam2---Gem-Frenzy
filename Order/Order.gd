class_name Order
extends Node2D

var requirements : Array # array de materiales (tamaño 1 a 3)
var precio : int:
	get:
		return precio

enum states {
	Pasado,	
	EnVistaPrevia,
	EnCurso,
	Done
}
var currState

func _init(materiales : Array):
	currState = states.EnVistaPrevia
	
	for material in materiales:
		requirements.append(material)
		
	match materiales.size():
		1: precio = 5
		2: precio = 12
		3: precio = 20
		
	print("se instancia: ", materiales, " precio: ", precio)
	

# Llamadas

func Queued() -> void:
	currState = states.EnCurso
	$Timer.start(30)

# Señales

func _on_timer_timeout():
	currState = states.Pasado
	precio /= 2

# debug

func _to_string():
	var str : String
	for e in requirements:
		str += str(e) # añadir un _to_string en cuanto tengamos los materiales
	return str
