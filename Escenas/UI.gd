extends Control

signal delegar_orden(o)
var paused = false


func _ready():
	GlobalTiempo.casifinalizardia.connect(show_end_day_alert)
	GlobalTiempo.quedamediahora.connect(queda_media_hora)
	GlobalTiempo.quedandiezminutos.connect(ten_minutes_left_flashing)
	GlobalTiempo.finalizarDia.connect(pausar_flash)
	GlobalTiempo.iniciarDia.connect(invisible_flash)
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
	%"Sonido boton".play()
	toggle_paused()
func invisible_flash():
	$VbReloj/Control/Sprite2D.visible=false
func toggle_paused():
	paused = !paused
	get_tree().paused = paused
	$Pausa.visible = paused
	$Btn_pause.disabled = paused
func show_end_day_alert():
	$VbReloj/Control/SonidoAlerta.play()
	$VbReloj/Control/AnimationPlayer.play("1_hour_left")
func anim_1_hour_flash():
	$VbReloj/Control/AnimationPlayer.play("1_hour_left_flashing")
func queda_media_hora():
	$VbReloj/Control/AnimationPlayer.play("half_hour_left_flashing")
func ten_minutes_left_flashing():
	$VbReloj/Control/AnimationPlayer.play("ten_minutes_left_flashing")
func pausar_flash():
	$VbReloj/Control/AnimationPlayer.stop()
