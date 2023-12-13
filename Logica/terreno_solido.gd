extends Area2D

var textura = GlobalRecursos.mineralesConFondo.Tierra

func _ready() -> void:
	$Sprite2D.frame = textura

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		# Todo poner limite de mochila si es el caso
		if $Sprite2D.frame < GlobalRecursos.mineralesConFondo.Tierra:
			GlobalRecursos.actualizar_mineral($Sprite2D.frame, 1)
		elif $Sprite2D.frame > GlobalRecursos.mineralesConFondo.TierraMinada:
			GlobalRecursos.actualizar_mineral($Sprite2D.frame - 2, 1)
		$Sprite2D.frame = GlobalRecursos.mineralesConFondo.TierraMinada
		

func actualizar_textura():
	$Sprite2D.frame = textura
