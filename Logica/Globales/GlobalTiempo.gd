extends Node


# El dia de trabajo va de 8 am a 6 pm, 10 horas
var tiempoHoraDia =  8 # horas
var tiempoMinutoDia = 0

var diaActual = 0

signal tiempoCambio(minuto, hora)
signal finalizarDia(dia)
signal iniciarDia
# por ahora el tiempo del dia son 10 minutos de la vida real

@onready var tmr_minuto : Timer
func _ready() -> void:
	tmr_minuto = Timer.new() 
	add_child(tmr_minuto)
	tmr_minuto.wait_time = 1
	tmr_minuto.timeout.connect(on_tmr_minuto_end)
	tmr_minuto.process_callback = Timer.TIMER_PROCESS_PHYSICS


# actualiza el reloj
func on_tmr_minuto_end():
	tiempoMinutoDia += 1
	if tiempoMinutoDia == 60:
		tiempoHoraDia += 1
		tiempoMinutoDia = 0
	tiempoCambio.emit(tiempoMinutoDia, tiempoHoraDia)
	if tiempoHoraDia == 18:
		tmr_minuto.stop()
		finalizarDia.emit(diaActual)

func siguiente_dia():
	iniciarDia.emit()
	diaActual += 1
	tiempoHoraDia = 8
	tiempoMinutoDia = 0
	tiempoCambio.emit(tiempoMinutoDia, tiempoHoraDia)
	tmr_minuto.start()
