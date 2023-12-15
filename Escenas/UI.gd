extends Control

signal delegar_orden(o)

func _on_recepcion_order_delivered(orden):
	delegar_orden.emit(orden)
