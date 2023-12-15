extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body is Player and body.taladrando:
		body.modolento=true
	pass # Replace with function body.

# Replace with function body.


func _on_body_exited(body):
	if body is Player and body.taladrando:
		body.modolento=false
	pass # Replace with function body.
