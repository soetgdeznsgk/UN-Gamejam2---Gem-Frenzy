extends Area2D

var texturaMinada = preload("res://Sprites/Mapa/terrenoMinado.png")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		$Sprite2D.texture = texturaMinada
