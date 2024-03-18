class_name OrderGem
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
	
	for mat in materiales: # mat va de 0 a 11 segun rareza
		requirements.append(mat)
		if mat <= 8:
			precio += (mat)
		else:
			precio += 8
		# maximo precio por ingrediente es 8

	@warning_ignore("integer_division")
	precio = int((precio / 6) + 1) # el promedio de lo anterior maximo 6 oro por receta
	
	tmr = Timer.new()
	add_child(tmr)
	tmr.timeout.connect(_on_timer_timeout)
	tmr.one_shot = true
	tmr.wait_time = 30 + (GlobalMejoras.activas_mejoras[3] * 5) # Por cada nivel de Zen en las mejoras, se añaden 5 segundos a las recetas
	if GlobalTuto.tutorial:
		tmr.wait_time=1900
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



