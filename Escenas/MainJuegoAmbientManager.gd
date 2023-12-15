extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalTiempo.iniciarDia.connect(reset_music)
	
# Señales

func reset_music():
	$Ambient.play(0)
