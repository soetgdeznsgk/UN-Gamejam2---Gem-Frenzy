extends VBoxContainer

var ordenUI = preload("res://orden_ui.tscn")
#var dirSprites = "res://Sprites/temporales_UI"

# Called when the node enters the scene tree for the first time.
func _ready():
	OrderManager.new_order.connect(_on_new_order)
	#for mineral in GlobalRecursos.MineralesSet:
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# Señales

func _on_new_order(orden : Order):
	var temp = ordenUI.instantiate()
	temp.setOrden(orden)
	add_child(temp)
	
