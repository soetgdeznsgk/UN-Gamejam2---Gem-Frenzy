extends Node2D
class_name Slime
var inicioy
var finaly
var tocandootroslimequestionmark=false
# Called when the node enters the scene tree for the first time.
func set_inicioy(nuevovalorinicioy):
	self.inicioy=nuevovalorinicioy
func set_finaly(nuevovalorfinaly):
	self.finaly=nuevovalorfinaly
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




func _on_area_entered(area):
#hacer coso de cambio de posicion aca jija
	if area is Slime:
		print(area.tocandootroslimequestionmark)
		print(finaly+inicioy)
		var xrandom=randi() % 550+20#de 50 a 640
		var yrandom=randi() % finaly+inicioy
		var modulox=xrandom%16
		var moduloy=yrandom%16
		#Para que el numero sea multiplo de 16
		if modulox!=0:
			xrandom+=(16-modulox)
		if moduloy!=0:
			yrandom+=(16-moduloy)
		area.position=Vector2(xrandom,yrandom)
	tocandootroslimequestionmark=true
	pass # Replace with function body.
