class_name Order
extends Node2D

signal out_of_time

var requirements : Array # array de materiales (tamaño 1 a 3)
var precio : int
var cliente_asociado : Cliente

@export var Tmr : Timer

enum states {
	EnVistaPrevia,
	EnCurso,
	Done
}
var currState
var tmr

func _init(materiales : Array, customer : Cliente):
	cliente_asociado = customer
	currState = states.EnVistaPrevia
	
	for material in materiales:
		requirements.append(material)
		precio += (material + 1) % 5 # Maximo 5 por mineral
		
	
	precio = (precio / 3) + 1 # el promedio de lo anterior maximo 6 oro por receta
	#print(precio)
	
	tmr = Timer.new()
	add_child(tmr)
	tmr.timeout.connect(_on_timer_timeout)
	tmr.one_shot = true
	tmr.wait_time = 30 + (GlobalMejoras.activas_mejoras[3] * 2.5) # Por cada nivel de Zen en las mejoras, se añaden 2.5 segundos a las recetas
	print(tmr.wait_time, " = wait time")
	tmr.process_callback = Timer.TIMER_PROCESS_PHYSICS
	tmr.autostart = true
	
# Llamadas

func Queued() -> void:
	currState = states.EnCurso
	
func get_time_left():
	return tmr.get_time_left()


# Señales

func _on_timer_timeout():
	cliente_asociado.esperando = false
	out_of_time.emit()
	 # se ejecuta tremendo set
	#queue_free() se hace free desde la orden_ui

func finalizar_orden():
	cliente_asociado.esperando = false
# debug

func _to_string():
	var stri := ""
	for e in requirements:
		stri += str(e) 
	return stri



