extends Label


func _ready():
	GlobalRecursos.rentadia.connect(update_rentaUI)

func update_rentaUI():
	text= tr("RENT")+" "+ str(GlobalRecursos.valorDia)
