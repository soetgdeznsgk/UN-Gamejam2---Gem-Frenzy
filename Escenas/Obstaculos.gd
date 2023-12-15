extends Node2D
class_name Genobstaculos
@onready var nodoobstaculos = $Obstaculos

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
	
	var cantidadA
	var cantidadB
	var cantidadC
	var diaactual=GlobalTiempo.diaActual
	print(diaactual)
	var Iniciocapas=20
	
	if diaactual==3:
		cantidadA=range(0,5)
		cantidadB=range(0,3)
		cantidadC=range(0,2)
		
		
	#primera capa
	#Tier A coso
	for i in range(0,5):
		var porcentaje = randf()
		Vectorposicionrandom =posicionrandom(1,50)
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
		slimenodo.set_inicioy(1)
		slimenodo.set_finaly(250)
		slimenodo.position=Vectorposicionrandom
		slimenodo.rotation=posibles_angulos[angulo]
	#capa 2
	for i in range(0,5):
		var porcentaje = randf()
		Vectorposicionrandom =posicionrandom(1,250)
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
		slimenodo2.set_inicioy(1)
		slimenodo2.set_finaly(250)
		slimenodo2.position=Vectorposicionrandom
		slimenodo2.rotation=posibles_angulos[angulo]
	for i in range(0,2):
		var porcentaje = randf()
		Vectorposicionrandom =posicionrandom(1,250)
		var angulo =0
		if porcentaje>0.66:
			slime2=load(Slimes[6])
			angulo=randi() % 3
		elif porcentaje>0.33:
			slime2=load(Slimes[7])
			angulo=randi() % 3
		else:
			slime2=load(Slimes[8])
			
		slimenodo2=slime2.instantiate()
		add_child(slimenodo2)
		slimenodo2.set_inicioy(1)
		slimenodo2.set_finaly(250)
		slimenodo2.position=Vectorposicionrandom
		slimenodo2.rotation=posibles_angulos[angulo]

func _process(delta):

	pass
func posicionrandom(inicioy,finaly):
	var xrandom=randi() % 640+50#de 50 a 640
	var yrandom=randi() % inicioy+finaly  #de 50 a 100
	var modulox=xrandom%16
	var moduloy=yrandom%16
	#Para que el numero sea multiplo de 16
	if modulox!=0:
		xrandom+=(16-modulox)
	if moduloy!=0:
		yrandom+=(16-moduloy)
		
	return Vector2(xrandom,yrandom)
	
	
	#GlobalTiempo.diaActual
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

