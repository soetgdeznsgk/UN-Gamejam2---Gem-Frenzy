extends VBoxContainer

var ordenUI = preload("res://Escenas/Ventana por Orden/orden_ui.tscn")
#var dirSprites = "res://Sprites/temporales_UI"

# Señales

func _on_new_order(orden : Order):
	var temp = ordenUI.instantiate()
	temp.setOrden(orden)
	add_child(temp)
	
