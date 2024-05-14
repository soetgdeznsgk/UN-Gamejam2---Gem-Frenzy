extends Node2D


func _ready():
	GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.Gato]=2
	GlobalMejoras.mejora_cambiada.emit()
