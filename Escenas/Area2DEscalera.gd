extends Area2D

var isPlayerHere = false
var playerRef : Player
@onready var interactSprite = $Spr_up_key_ladder


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if isPlayerHere:
		if Input.is_action_just_pressed("ui_up"):
			var tween :Tween = get_tree().create_tween()
			playerRef.movement = false
			
			
			#playerRef.Anim.set("parameters/Escaleras", "Play")
			
			tween.tween_property(playerRef, "position:x", position.x, 0.2)
			tween.tween_property(playerRef, "position:y", 12, 0.7)
			tween.tween_callback(_on_tween_callback)

func _on_tween_callback():

	playerRef.taladrando = true
	playerRef.movement = true
	playerRef.input_direction = Vector2.ZERO
	playerRef.last_move=Vector2.ZERO

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		isPlayerHere = true
		playerRef = body
		interactSprite.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		isPlayerHere = false
		interactSprite.visible = false
