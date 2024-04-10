extends Control

signal delegar_orden(o)
var paused = false


func _ready():
	if GlobalTuto.tutorial:
		GlobalTiempo.tiempoHoraDia= -9999
		$Renta.visible=false

func _on_recepcion_order_delivered(orden):
	delegar_orden.emit(orden)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		paused = !paused
		get_tree().paused = paused
		$Pausa.visible = paused
		$Btn_pause.disabled = paused

func _on_btn_pause_pressed() -> void:
	paused = !paused
	get_tree().paused = paused
	$Pausa.visible=true
	$Btn_pause.disabled=true

func _on_btn_back_pressed():
	paused = !paused
	get_tree().paused = paused
	$Pausa.visible=false
	$Btn_pause.disabled=false
