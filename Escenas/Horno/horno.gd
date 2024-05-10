extends Node2D
var isPlayerHere = false
var playerRef : Player
@onready var interactSprite = $Spr_up_key_ladder

func _process(_delta: float) -> void:
	if isPlayerHere:
		if Input.is_action_just_pressed("ui_up"):
			Cocinar()

# Llamadas

func Cocinar():
	var temp = playerRef.darObjetos()
	var receta := GlobalRecetas.encontrarReceta(temp)
	if receta != -1:
		GlobalLogros.check_AllRecipes(receta)
		playerRef.receta_en_mano = receta
		$AudioStreamPlayer.pitch_scale = 1.01
		$AudioStreamPlayer.play(0)
		if GlobalTuto.tutorial and GlobalTuto.FlagRecetaOrden:
			GlobalTuto.recetaToOrden.emit()
			
	else:
		$AudioStreamPlayer.pitch_scale = 0.65
		$AudioStreamPlayer.play(0)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		isPlayerHere = true
		playerRef = body
		interactSprite.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		isPlayerHere = false
		interactSprite.visible = false
