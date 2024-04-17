extends Control

signal delegar_orden(o)
var paused = false


func _ready():
	if GlobalTuto.tutorial:
		GlobalTiempo.tiempoHoraDia= -9999
		$Renta.visible=false
	$factura/AnimationPlayer.play("RESET")

func _on_recepcion_order_delivered(orden):
	delegar_orden.emit(orden)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_paused()

func _on_btn_pause_pressed() -> void:
	toggle_paused()

func _on_btn_back_pressed():
	toggle_paused()

func toggle_paused():
	paused = !paused
	get_tree().paused = paused
	$Pausa.visible = paused
	$Btn_pause.disabled = paused
