extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.Gato]=2
	GlobalMejoras.mejora_cambiada.emit()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
