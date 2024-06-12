extends Control
@onready var outro = %OutroAnim

func _ready() -> void:
	outro.endOutro.connect(outro_end)

func _on_no_pressed():
	visible=false
	GlobalRecursos.cambioDinero.emit(GlobalRecursos.dinero+10)
	GlobalRecursos.dinero+=10
	%FinalizarDia/VBoxContainer/HbMejoras/VBoxContainerMejora/TextureRect.modulate= Color("#ffffff")

func _on_si_pressed():
	#outro
	%FinalizarDia/Musicatienda.stop()
	GlobalLogros.juegoCompleto.emit()
	GlobalTiempo.winner.emit()
	outro.visible = true
	visible=false
func outro_end():
	visible = false
	%Gameover.visible=true
	%Gameover.z_as_relative = false
	%Gameover.z_index = 1000
	


func _on_visibility_changed():
	if visible:
		# se llamó como popup
		%FinalizarDia.modulate = Color("#adadad")
	else:
		# le dieron que nao nao
		%FinalizarDia.modulate = Color("#ffffff")
