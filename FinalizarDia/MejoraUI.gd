extends VBoxContainer

var info : Array

func _ready() -> void:
	info = GlobalMejoras.obtener_mejora_random_disponible()
	print(info)

func _on_btn_comprar_pressed() -> void:
	# solo puede comprar una vez hasta el maximo
	pass # Replace with function body.
