extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalRecursos.cambioMineral.connect(actualizar_mineral_ui)
	GlobalTiempo.iniciarDia.connect(update_mineralesactuales)

func actualizar_mineral_ui(mineral, cantidad):
	var node :Label = get_node("HBoxContainer"+str(mineral+1)+"/Label"+str(mineral+1))
	node.text = ":" + str(cantidad)
	if cantidad == 0:
		node.set("theme_override_colors/font_outline_color", Color("#cf2929") )
	else:
		node.set("theme_override_colors/font_outline_color", Color("#000000") )

#hace que la ui muestre los minerales que se pueden recolectar, dependiendo del dia
func update_mineralesactuales():
	match GlobalTiempo.diaActual:
		#hace visible el cobre
		2:
			$HBoxContainer5.visible = true
		#oro
		3:
			$HBoxContainer3.visible = true
		4:
			$HBoxContainer7.visible = true
			$HBoxContainer8.visible = true
		6:
			#azul
			$HBoxContainer9.visible = true
			#morado
			$HBoxContainer6.visible = true
		7:
			#verde
			$HBoxContainer11.visible = true
			
		8:
			#diamante
			$HBoxContainer10.visible = true
