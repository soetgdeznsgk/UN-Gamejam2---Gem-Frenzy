extends Node2D
class_name Genobstaculos

var Slimes=PackedStringArray([# Tier A (0 a 2)
					"res://Escenas/obstaculos/slimes/TierAslime1.tscn",
					"res://Escenas/obstaculos/slimes/TierAslime2.tscn",
					"res://Escenas/obstaculos/slimes/TierAslime3.tscn",
					# Tier B (3 a 5)
					"res://Escenas/obstaculos/slimes/TierBslime1.tscn",
					"res://Escenas/obstaculos/slimes/TierBslime2.tscn",
					"res://Escenas/obstaculos/slimes/TierBslime3.tscn",
					# Tier C (6 a 8)
					"res://Escenas/obstaculos/slimes/TierCslime1.tscn",
					"res://Escenas/obstaculos/slimes/TierCslime2.tscn",
					"res://Escenas/obstaculos/slimes/TierCslime3.tscn"])
var posibles_angulos=[0,PI*0.5,PI,PI*1.5]#GODOT USA RADIANES 😭
var slime
var slime2
var slimenodo2
var slimenodo
var Vectorposicionrandom

# Called when the node enters the scene tree for the first time.
func _ready():
	#conecta la señal iniciar dia en la funcion empezar dia
	GlobalTiempo.iniciarDia.connect(empezardia)
	empezardia()
	GlobalTiempo.finalizarDia.connect(terminaciondeldia)
func terminaciondeldia():
	for child in get_children():
		child.queue_free()
		
func empezardia():
	#cantidadA= cantidad de slimes tierA que van a spawnear
	var cantidadA
	var cantidadB
	var cantidadC
	var diaactual=GlobalTiempo.diaActual
	var Iniciocapas=45
	#finalA -> en que coordenada de y dejan de spawnear slimes tierA 
	var finalA
	var finalB
	var finalC=250
	#inicioC -> en que coordenada de y empiezan a spawnear slimes tierC
	var inicioC
	var inicioB
	
	match diaactual:
		1:
			cantidadA=range(0,5)
			cantidadB=range(0,3)
			cantidadC=range(0,0)
			finalA=50
			inicioB=Iniciocapas
			finalB=50
			finalC=1
		2:
			cantidadA=range(0,10)
			cantidadB=range(0,6)
			cantidadC=range(0,0)
			finalA=100
			inicioB=120
			finalB=125
			finalC=91	
			#inicioC=Iniciocapas
		#dia 3 max 340
		3:
			cantidadA=range(0,13)
			cantidadB=range(0,8)
			cantidadC=range(0,3)
			finalA=260
			inicioB=150
			finalB=200
			inicioC=250
			finalC=300	
		4:
			#print("ES EL DIA 4 PAPUS")
			cantidadA=range(0,18)
			cantidadB=range(0,8)
			cantidadC=range(0,4)
			finalA=425
			inicioB=300
			finalB=400
			inicioC=400
			finalC=450	
		5:
			cantidadA=range(0,18)
			cantidadB=range(0,8)
			cantidadC=range(0,4)
			finalA=425
			inicioB=300
			finalB=400
			inicioC=400
			finalC=450	
		6:
			cantidadA=range(0,22)
			cantidadB=range(0,10)
			cantidadC=range(0,6)
			finalA=700
			inicioB=400
			finalB=600
			inicioC=600
			finalC=700	
		7:
			cantidadA=range(0,24)
			cantidadB=range(0,12)
			cantidadC=range(0,8)
			finalA=900
			inicioB=500
			finalB=800
			inicioC=600
			finalC=900	
		8:
			cantidadA=range(0,24)
			cantidadB=range(0,14)
			cantidadC=range(0,10)
			finalA=1100
			inicioB=500
			finalB=1000
			inicioC=900
			finalC=1100	
	if diaactual>8:
			cantidadA=range(0,27)
			cantidadB=range(0,16)
			cantidadC=range(0,10)
			finalA=1190
			inicioB=500
			finalB=1190
			inicioC=900	
			finalC=1190	
	#primera capa
	#Tier A coso
	for i in cantidadA:
		var porcentaje = randf()
		Vectorposicionrandom =posicionrandom(Iniciocapas,finalA)
		var angulo =0
		if porcentaje>0.66:
			slime=load(Slimes[0])
			
		elif porcentaje>0.33:
			slime=load(Slimes[1])
			angulo=randi() % 3
		else:
			slime=load(Slimes[2])
			angulo=randi() % 1
		slimenodo=slime.instantiate()
		add_child(slimenodo)
		slimenodo.set_inicioy(Iniciocapas)
		slimenodo.set_finaly(finalA)
		slimenodo.position=Vectorposicionrandom
		slimenodo.rotation=posibles_angulos[angulo]
		var tocandoslime=slimenodo.get_overlapping_areas()
		print("slimeagain: ",tocandoslime)
		#while tocandoslime==true:
		#	slimenodo.position=posicionrandom(Iniciocapas,finalA)
	#capa 2
	for i in cantidadB:
		var porcentaje = randf()
		Vectorposicionrandom =posicionrandom(inicioB,finalB)
		var angulo =0
		if porcentaje>0.66:
			slime2=load(Slimes[3])
			angulo=randi() % 3
		elif porcentaje>0.33:
			slime2=load(Slimes[4])
			angulo=randi() % 3
		else:
			slime2=load(Slimes[5])
			
		slimenodo2=slime2.instantiate()
		add_child(slimenodo2)
		slimenodo2.set_inicioy(inicioB)
		slimenodo2.set_finaly(finalB)
		slimenodo2.position=Vectorposicionrandom
		slimenodo2.rotation=posibles_angulos[angulo]
	for i in cantidadC:
		var porcentaje = randf()
		Vectorposicionrandom =posicionrandom(inicioC,finalC)
		var angulo =0
		if porcentaje>0.66:
			slime2=load(Slimes[6])
			angulo=randi() % 1
		elif porcentaje>0.33:
			slime2=load(Slimes[7])
			angulo=randi() % 3
		else:
			slime2=load(Slimes[8])
			angulo=randi() % 3
			
		slimenodo2=slime2.instantiate()
		add_child(slimenodo2)
		
		slimenodo2.set_inicioy(inicioC)
		slimenodo2.set_finaly(finalC)
		
		slimenodo2.position=Vectorposicionrandom
		slimenodo2.rotation=posibles_angulos[angulo]
	print("terminó el spawn papus")

func posicionrandom(inicioy,finaly):
	var xrandom=randi() % 570#de 50 a 640
	var yrandom=randi_range(inicioy,finaly)  #de 50 a 100
	var modulox=xrandom%16
	var moduloy=yrandom%16
	#Para que el numero sea multiplo de 16
	if modulox!=0:
		xrandom+=(16-modulox)
	if moduloy!=0:
		yrandom+=(16-moduloy)
		
	return Vector2(xrandom,yrandom)
