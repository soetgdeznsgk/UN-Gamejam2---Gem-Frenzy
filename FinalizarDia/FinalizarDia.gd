extends ColorRect

@onready var grid = $GridContainerMejoras
var mejoraUI = preload("res://FinalizarDia/MejoraUI.tscn")

func _ready() -> void:
	GlobalTiempo.finalizarDia.connect(_on_finalizar_dia)

func _on_finalizar_dia(dia : int):
	#todo que las mejoras salgan aleatoriamente aca, excepto si ya hay un maximo
	# var arr mejoras disponibles  = ...
	# for i in mejoras disponibles...
	var temp = mejoraUI.instantiate()
	grid.add_child(temp)
	
	%FinalizarDia.visible = true

func _on_btn_finalizar_dia_pressed() -> void:
	visible = false
	GlobalTiempo.siguiente_dia()
