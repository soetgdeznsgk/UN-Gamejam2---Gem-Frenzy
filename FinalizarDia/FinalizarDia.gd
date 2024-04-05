extends PanelContainer

@onready var grid = $VBoxContainer/HbMejoras
var mejoraUI = preload("res://FinalizarDia/MejoraUI.tscn")
var infoMejorasDisponibles : Array

func _ready() -> void:
	GlobalTiempo.finalizarDia.connect(_on_finalizar_dia)
	GlobalRecursos.bancarota.connect(gameover)

func _on_finalizar_dia():
	if GlobalRecursos.dinero >= 0:
		infoMejorasDisponibles = GlobalMejoras.obtener_mejora_random_disponible()
		for i in infoMejorasDisponibles:
			var temp = mejoraUI.instantiate()
			temp.info = i
			grid.add_child(temp)
		$AudioFinDiaBien.play()
		%FinalizarDia.visible = true
	%FinalizarDia.visible =false
	%factura.visible=true
	%factura/HBoxContainer/preciocosaspagadas/AhorroNumerito.text="  "+str(GlobalRecursos.Ahorro)
	%factura/HBoxContainer/preciocosaspagadas/GananciadiaNum.text="\n  "+str(GlobalRecursos.Gananciadia)
	%factura/HBoxContainer/preciocosaspagadas/GananciabonoNum.text="\n  "+str(GlobalRecursos.Gananciabono)
	%factura/HBoxContainer/preciocosaspagadas/GananciaReciclajeNum.text="\n  "+str(GlobalRecursos.GananciaReciclaje)
	%factura/HBoxContainer/preciocosaspagadas/RentaNum.text="\n -"+str(GlobalRecursos.valorDia)
	var sumatotal=GlobalRecursos.Ahorro+GlobalRecursos.Gananciadia+GlobalRecursos.Gananciabono+GlobalRecursos.GananciaReciclaje-GlobalRecursos.valorDia
	%factura/HBoxContainer/preciocosaspagadas/Totalnum.text="\n\n\n\n  "+str(sumatotal)
	if sumatotal<0:
		%Gameover.visible=false
		%factura/HBoxContainer/preciocosaspagadas/Totalnum.modulate=Color("#d82118")
	
	#+"\nGanancia bono:                            \t"+str(GlobalRecursos.Gananciabono)+"\nGanancia Reciclaje de minerales:\t"+str(GlobalRecursos.GananciaReciclaje)+"\nRenta:                                   \t-"\
	#+str(GlobalRecursos.valorDia)
	#print("factura--- \n",GlobalRecursos.Gananciadia,"\n",GlobalRecursos.Gananciabono,"\n",GlobalRecursos.GananciaReciclaje,"\n -",GlobalRecursos.valorDia)

func _on_btn_finalizar_dia_pressed() -> void:
	visible = false
	for child in grid.get_children():
		child.queue_free()
	GlobalTiempo.siguiente_dia()

func gameover():
	await get_tree().create_timer(0.1).timeout
	visible = false
