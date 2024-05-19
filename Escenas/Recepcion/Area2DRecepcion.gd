extends Area2D

class_name Recepcion

signal order_delivered(orden)

var isPlayerHere = false
var playerRef : PlayerPancha
@onready var interactSprite = $Spr_up_key_ladder


func _process(_delta: float) -> void:
	if isPlayerHere:
		if Input.is_action_just_pressed("ui_up"):
			Entrega()

# Llamadas

func Entrega():
	if playerRef.receta_en_mano:
		order_delivered.emit(playerRef._set_receta(false))
	else:
		$AudioNotieneNada.play()

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerPancha:
		isPlayerHere = true
		playerRef = body
		interactSprite.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body is PlayerPancha:
		isPlayerHere = false
		interactSprite.visible = false
