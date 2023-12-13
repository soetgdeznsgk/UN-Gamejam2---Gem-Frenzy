extends Node

func _ready():
	for i in range(get_child_count()):
		get_child(i).material_almacenado = i

func _on_player_surface_entered():
	for cofreI in range(get_child_count()):
		get_child(cofreI).cantidad_almacenada += GlobalRecursos.minerales[cofreI]
		GlobalRecursos.actualizar_mineral(cofreI, 0)
