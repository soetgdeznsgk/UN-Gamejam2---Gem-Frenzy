extends Area2D

var textura = 6

func _ready() -> void:
	$Sprite2D.frame = textura

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		$Sprite2D.frame = 7
