extends Node2D

var plato : String
var requerimentos : Array

func _init(nombre: String, req: Array): # a terminar cuando esté implementado el cofre
	plato = nombre
	requerimentos = Array()
	requerimentos.append_array(req)
	
