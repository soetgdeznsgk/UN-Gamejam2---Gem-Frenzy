extends Node


# El dia de trabajo va de 8 am a 6 pm, 10 horas
var tiempoHoraDia =  8 # horas
var tiempoMinutoDia = 0
var diaActual = 1

signal tiempoCambio(minuto, hora)
signal finalizarDia()
signal iniciarDia
# por ahora el tiempo del dia inicia en 3 min de tiempo real pero se puede mejorar el tiempo

@onready var tmr_minuto : Timer
func _ready() -> void:
	tmr_minuto = Timer.new() 
	add_child(tmr_minuto)
	tmr_minuto.wait_time = 0.45
	
	tmr_minuto.timeout.connect(on_tmr_minuto_end)
	tmr_minuto.process_callback = Timer.TIMER_PROCESS_PHYSICS

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		tiempoHoraDia += 1

# actualiza el reloj
func on_tmr_minuto_end():
	tiempoMinutoDia += 1
	if tiempoMinutoDia == 60:
		tiempoHoraDia += 1
		tiempoMinutoDia = 0
	tiempoCambio.emit(tiempoMinutoDia, tiempoHoraDia)
	if tiempoHoraDia >= 11 + (GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.MasTiempo] * 0.5):
		tmr_minuto.stop()
		finalizarDia.emit()

func siguiente_dia():
	diaActual += 1
	
	if diaActual<=8:
		tmr_minuto.wait_time = 0.45+ diaActual*0.01
	else:
		tmr_minuto.wait_time = 0.5
	tiempoHoraDia = 8
	tiempoMinutoDia = 0
	tiempoCambio.emit(tiempoMinutoDia, tiempoHoraDia)
	iniciarDia.emit()
	tmr_minuto.start()
