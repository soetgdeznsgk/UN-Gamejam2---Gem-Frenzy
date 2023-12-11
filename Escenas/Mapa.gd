extends Node2D

var terreno = preload("res://Logica/terreno_solido.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0,80):
		for j in range(0,160):
			var temp = terreno.instantiate()
			temp.position = Vector2(i*8,j*8)
			add_child(temp)
