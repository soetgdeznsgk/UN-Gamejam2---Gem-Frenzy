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
	requirements = materiales
	cliente_asociado = customer
	currState = states.EnVistaPrevia
	@warning_ignore("integer_division")
	match GlobalRecetas.encontrarReceta(materiales): # Quitar la formula fea y progression mejor
		GlobalRecetas.Acero:
			precio = 1
		GlobalRecetas.Allmetal:
			precio = 2
		GlobalRecetas.CristalFuego:
			precio = 4
		GlobalRecetas.CristalFrio:
			precio = 5
		GlobalRecetas.CristalRGB:
			precio = 6
		GlobalRecetas.CristalAgua:
			precio = 8
		GlobalRecetas.CristalTierra:
			precio = 6
	
	tmr = Timer.new()
	add_child(tmr)
	tmr.timeout.connect(_on_timer_timeout)
	tmr.one_shot = true
	tmr.wait_time = 24 + (GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.ClientesZen] * 8) # Por cada nivel de Zen en las mejoras, se añaden 5 segundos a las recetas
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
	cliente_asociado.se_fue_bravo()
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



