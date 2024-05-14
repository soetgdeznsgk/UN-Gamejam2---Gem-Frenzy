extends Control

@onready var grid = $VBoxContainer/HbMejoras
var mejoraUI = preload("res://FinalizarDia/MejoraUI.tscn")
var infoMejorasDisponibles : Array

func _ready() -> void:
	GlobalTiempo.finalizarDia.connect(_on_finalizar_dia)
	GlobalRecursos.bancarota.connect(gameover)
	%Gameover/VBoxContainer/Label.text=tr("BANKRUPTCY")
	%Gameover/VBoxContainer/Label.label_settings.font_color=Color("#f23030")
func _on_finalizar_dia():
	if GlobalRecursos.dinero >= 0:
		infoMejorasDisponibles = GlobalMejoras.obtener_mejora_random_disponible()
		if infoMejorasDisponibles.size()==4:
			$VBoxContainer.position.x+=5
			$VBoxContainer/HbMejoras.add_theme_constant_override("separation",0)
		for i in infoMejorasDisponibles:
			var temp = mejoraUI.instantiate()
			temp.info = i
			grid.add_child(temp)
		$AudioFinDiaBien.play()

#region Mostrar  Factura
	
	%factura.visible=true
	%"factura/HBoxContainer/cosas pagadas/HBoxahorro/AhorroNumerito".text="  "+str(GlobalRecursos.Ahorro)
	%"factura/HBoxContainer/cosas pagadas/HBoxGanancia/GananciadiaNum".text="  "+str(GlobalRecursos.Gananciadia)
	%"factura/HBoxContainer/cosas pagadas/HBoxBono/GananciabonoNum".text="  "+str(GlobalRecursos.Gananciabono)
	%"factura/HBoxContainer/cosas pagadas/HBoxReciclaje/GananciaReciclajeNum".text="  "+str(GlobalRecursos.GananciaReciclaje)
	%"factura/HBoxContainer/cosas pagadas/HBoxRent/RentaNum".text=" -"+str(GlobalRecursos.valorDia)
	var sumatotal=GlobalRecursos.Ahorro+GlobalRecursos.Gananciadia+GlobalRecursos.Gananciabono+GlobalRecursos.GananciaReciclaje-GlobalRecursos.valorDia
	%"factura/HBoxContainer/cosas pagadas/VboxContainer/HBoxTotal/Totalnum".text="  "+str(sumatotal)
	if sumatotal<0:
		%Gameover.visible=false
		%"factura/HBoxContainer/cosas pagadas/VboxContainer/HBoxTotal/Totalnum".modulate=Color("#d82118")
	
#endregion


	
func gameover():
	await get_tree().create_timer(0.1).timeout
	visible = false


func _on_btn_finalizar_dia_pressed() -> void:
	for child in grid.get_children():
		child.queue_free()
	GlobalTiempo.siguiente_dia()
	visible = false
	pass # Replace with function body.
