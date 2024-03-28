extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalRecursos.rentadia.connect(update_rentaUI)
	pass # Replace with function body.

func update_rentaUI():
	text= tr("RENT")+" "+ str(GlobalRecursos.valorDia)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
