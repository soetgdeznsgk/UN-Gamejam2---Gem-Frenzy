extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_no_pressed():
	visible=false
	GlobalRecursos.cambioDinero.emit(GlobalRecursos.dinero+10)
	GlobalRecursos.dinero+=10
	
	
	pass # Replace with function body.


func _on_si_pressed():
	%Gameover.call_top_players()
	%Gameover/VBoxContainer/Label.text=tr("CONGRATS")
	%Gameover/VBoxContainer/Label.label_settings.font_color=Color("#13E65F")
	%LbSelfDia.text = tr("DAY") + " " + str(GlobalTiempo.diaActual)
	await get_tree().create_timer(1.5).timeout
	%Gameover.visible=true
	pass # Replace with function body.
