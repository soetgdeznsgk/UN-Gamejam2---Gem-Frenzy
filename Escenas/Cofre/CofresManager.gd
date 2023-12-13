extends Node

func _ready():
	for i in range(get_child_count()):
		get_child(i).material_almacenado = i

func _on_player_surface_entered():
	for cofreI in range(get_child_count()):
		get_child(cofreI).cantidad_almacenada += GlobalRecursos.minerales_pj[cofreI]
		get_child(cofreI).animPlayer.play("AbrirCofre")
		GlobalRecursos.actualizar_mineral_cofre(cofreI, GlobalRecursos.minerales_pj[cofreI])
		GlobalRecursos.minerales_pj[cofreI] = 0
		GlobalRecursos.actualizar_mineral_pj(cofreI, 0)
