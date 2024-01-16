extends Area2D

var isPlayerHere = false
var playerRef : Player
@onready var interactSprite = $Spr_up_key_ladder

@export var isUp = false
var tween : Tween

func _ready() -> void:
	GlobalTiempo.finalizarDia.connect(fin_dia)

func fin_dia():
	if tween:
		tween.stop()

func _process(_delta: float) -> void:
	
	if isPlayerHere:
		if Input.is_action_just_pressed("ui_up") and playerRef.movement == true:
			playerRef.movement = false
			tween = get_tree().create_tween()
			if isUp:
				tween.tween_property(playerRef, "position:x", 432, 0.2)
				tween.tween_property(playerRef, "position", Vector2(429,-29), 0.15)
				tween.tween_property(playerRef, "position", Vector2(421,-37), 0.15)
				tween.tween_property(playerRef, "position", Vector2(413,-45), 0.15)
				tween.tween_property(playerRef, "position", Vector2(405,-53), 0.15)
				tween.tween_property(playerRef, "position", Vector2(388,-61), 0.15)
			else:
				tween.tween_property(playerRef, "position", Vector2(388,-61), 0.15)
				tween.tween_property(playerRef, "position", Vector2(405,-53), 0.15)
				tween.tween_property(playerRef, "position", Vector2(413,-45), 0.15)
				tween.tween_property(playerRef, "position", Vector2(421,-37), 0.15)
				tween.tween_property(playerRef, "position", Vector2(429,-29), 0.15)
				tween.tween_property(playerRef, "position", Vector2(432,-21), 0.15)
			tween.tween_callback(_on_tween_callback)

func _on_tween_callback():
	playerRef._on_ladder_finish()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		isPlayerHere = true
		playerRef = body
		interactSprite.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		isPlayerHere = false
		interactSprite.visible = false
