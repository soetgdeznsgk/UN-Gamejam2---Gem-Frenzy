extends Area2D

signal order_delivered(orden)

var isPlayerHere = false
var playerRef : Player
var tween : Tween
@onready var interactSprite = $Spr_up_key_ladder

func _ready() -> void:
	GlobalTiempo.finalizarDia.connect(fin_dia)

func fin_dia():
	if tween:
		tween.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if isPlayerHere:
		if Input.is_action_just_pressed("ui_up") and playerRef.movement == true:
			tween = get_tree().create_tween()
			playerRef.movement = false
			tween.tween_property(playerRef, "position:x", position.x, 0.2)
			tween.tween_property(playerRef, "position:y", 12, 0.7)
			tween.tween_callback(_on_tween_callback)

func _on_tween_callback():
	playerRef.taladrando = true
	playerRef.movement = true
	playerRef.input_direction = Vector2.ZERO
	playerRef.last_move=Vector2.ZERO
	playerRef.recienSalidoEscalera = true

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		isPlayerHere = true
		playerRef = body
		interactSprite.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		isPlayerHere = false
		interactSprite.visible = false
