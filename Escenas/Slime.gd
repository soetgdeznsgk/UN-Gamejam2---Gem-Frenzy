extends Node2D
class_name Slime
var inicioy
var finaly
var iniciocy=0
var finalcy=0
var isC=false #POR FAVOR QUE NADIE VEA ESTE CODIGO PERO QUEDAN 3 HORAS PARA ACABAR O ALGO ASI 😭😭
var TocandoSlime:bool=false
var movido:int=0

# Called when the node enters the scene tree for the first time.
func set_inicioy(nuevovalorinicioy):
	self.inicioy=nuevovalorinicioy

func set_finaly(nuevovalorfinaly):
	self.finaly=nuevovalorfinaly

func set_inicioCy(NUEVOVALORFUNCIONAPLS1,NUEVOVALORFUNCIONAPLS2):
	self.iniciocy=NUEVOVALORFUNCIONAPLS1
	self.finalcy=NUEVOVALORFUNCIONAPLS2
	self.isC=true

func _on_area_entered(area):
#hacer coso de cambio de posicion aca jija
	print("slime veces movido: ",movido," tocandoslimebooleano: ",TocandoSlime)
	if area is Slime:
		TocandoSlime=true	
		if movido<=15:
			reposicionar()
		else:
			TocandoSlime=true
		#var xrandom=randi() % 570+20#de 50 a 640
		#var yrandom
	
func reposicionar():
	
	var xrandom=randi() % 570+20#de 50 a 640
	var yrandom=randi_range(inicioy,finaly)
	var modulox=xrandom%16
	var moduloy=yrandom%16
		
	#Para que el numero sea multiplo de 16
	if modulox!=0:
		xrandom-=(16-modulox)
	if moduloy!=0:
		yrandom-=(16-moduloy)
	#print("modulo XRANDOM: ",xrandom,"\n modulo YRANDOM ",yrandom)
	#print("valor yrandom al corregir: ",yrandom)
	self.position=Vector2(xrandom,yrandom)
	movido+=1
	TocandoSlime=false
	
func _on_body_entered(body):
	if body is Player and body.taladrando:
		body.modolento=true

func _on_body_exited(body):
	if body is Player and body.taladrando:
		body.modolento=false

