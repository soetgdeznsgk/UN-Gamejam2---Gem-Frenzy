extends Node

# El dia de trabajo va de 8 am a 11
var tiempoHoraDia =  8 # horas
var tiempoMinutoDia = 0
var diaActual = 1
var tiempoJuegoTotal = 0
signal tiempoCambio(minuto, hora)
signal finalizarDia
signal iniciarDia
# por ahora el tiempo del dia inicia en 3 min de tiempo real pero se puede mejorar el tiempo

@onready var tmr_minuto : Timer
@onready var tmr_segundos_totales : Timer


func _ready() -> void:
	tmr_minuto = Timer.new()
	tmr_segundos_totales = Timer.new()
	tmr_minuto.wait_time = 0.48
	tmr_minuto.timeout.connect(on_tmr_minuto_end)
	tmr_minuto.process_callback = Timer.TIMER_PROCESS_PHYSICS
	tmr_segundos_totales.wait_time = 1
	tmr_segundos_totales.timeout.connect(on_tmr_segundos_totales_end)
	add_child(tmr_minuto)
	add_child(tmr_segundos_totales)
	
func on_tmr_segundos_totales_end():
	tiempoJuegoTotal += 1

func start_time():
	tiempoHoraDia = 8
	tiempoMinutoDia = 0
	tiempoCambio.emit(tiempoMinutoDia, tiempoHoraDia)
	tmr_minuto.start()
	tmr_segundos_totales.start()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_text_delete"):
		tiempoHoraDia += 1

# actualiza el reloj
func on_tmr_minuto_end():
	tiempoMinutoDia += 1
	if tiempoMinutoDia == 60:
		tiempoHoraDia += 1
		tiempoMinutoDia = 0
	tiempoCambio.emit(tiempoMinutoDia, tiempoHoraDia)
	if tiempoHoraDia >= 11 + (GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.MasTiempo]):
		tmr_minuto.stop()
		finalizarDia.emit()

func siguiente_dia():
	diaActual += 1
	if diaActual<=10:
		tmr_minuto.wait_time = 0.45+ diaActual*0.012
	else:
		tmr_minuto.wait_time = 0.6
	start_time()
	iniciarDia.emit()
