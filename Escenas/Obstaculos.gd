extends Node2D

var slime1scene = preload("res://Escenas/obstaculos/slime2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var slime1nodo=slime1scene.instantiate()
	add_child(slime1nodo)
	
	print("hola chat")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
