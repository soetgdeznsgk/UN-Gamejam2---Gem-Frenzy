extends Control


func _ready() -> void:
	GlobalLogros.mostrarNotificacion.connect(mostrar_notificacion)


func mostrar_notificacion(tex,titulo):
	$IconoLogro.texture = tex
	$Titulo.text = titulo
	$AnimationPlayer.play("slideInOut")
