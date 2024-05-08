extends Node2D

func comer_gema(numGema:int):
	self.get_child(numGema).visible=false
	
func spawnear_gemas():
	for i in range(0,5):
		self.get_child(i).visible=true
