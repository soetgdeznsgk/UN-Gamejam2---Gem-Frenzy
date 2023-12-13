extends Area2D

var isPlayerHere = false
var playerRef : Player
@onready var interactSprite = $Spr_up_key_ladder


func _process(_delta: float) -> void:
	if isPlayerHere:
		if Input.is_action_just_pressed("ui_up"):
			# Entregar horno
			pass
			

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		isPlayerHere = true
		playerRef = body
		interactSprite.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		isPlayerHere = false
		interactSprite.visible = false
