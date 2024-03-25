extends Control

signal delegar_orden(o)
var paused = false
func _ready():
	if GlobalTuto.tutorial:
		GlobalTiempo.tiempoHoraDia= -9999
func _on_recepcion_order_delivered(orden):
	delegar_orden.emit(orden)


func _on_btn_pause_pressed() -> void:
	paused = !paused
	get_tree().paused = paused
