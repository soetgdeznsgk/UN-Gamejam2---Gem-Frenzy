extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalRecursos.cambioMineral.connect(actualizar_mineral_ui)
	GlobalTiempo.iniciarDia.connect(update_mineralesactuales)

func actualizar_mineral_ui(mineral, cantidad):
	get_child(mineral*2 + 1).text = ": " + str(cantidad)
#hace que la ui muestre los minerales que se pueden recolectar, dependiendo del dia
func update_mineralesactuales():
	match GlobalTiempo.diaActual:
		#hace visible el cobre
		2:
			get_child(8).visible=true
			get_child(9).visible=true
		3:
			get_child(4).visible=true
			get_child(5).visible=true
		4:
			get_child(12).visible=true
			get_child(13).visible=true
			get_child(14).visible=true
			get_child(15).visible=true
		6:
			get_child(10).visible=true
			get_child(11).visible=true
			#zafiro
			get_child(16).visible=true
			get_child(17).visible=true
		7:
			get_child(20).visible=true
			get_child(21).visible=true
			
		8:
			get_child(18).visible=true
			get_child(19).visible=true
	print("hola chat")
