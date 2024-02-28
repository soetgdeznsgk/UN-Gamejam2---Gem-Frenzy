extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func comer_gema(numGema:int):
	self.get_child(numGema).visible=false
	
func spawnear_gemas():
	for i in range(0,5):
		self.get_child(i).visible=true
