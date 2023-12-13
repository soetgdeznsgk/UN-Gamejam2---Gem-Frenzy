extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalRecursos.cambioMineralPj.connect(actualizar_mineral_ui)


func actualizar_mineral_ui(mineral, cantidad):
	get_child(mineral*2 + 1).text = ": " + str(cantidad)
