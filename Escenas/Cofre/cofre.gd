extends Node2D

@export var num_cofre : int
@export var material_almacenado : int:
	set(value):
		material_almacenado = value
		$Sprite2D/Imagen.frame = material_almacenado
var cantidad_almacenada := 0
@onready var popup := $Spr_up_key_ladder
var isPlayerHere := false
var playerRef : Player
@onready var animPlayer = $AnimationPlayer
var activo = false

func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isPlayerHere:
		if Input.is_action_just_pressed("ui_up"):
			Open()
	

func actualizar():
	var pt = GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.CofreMineral]*2
	if num_cofre < 3 + pt:
		visible = true
		activo = true

# Llamadas

func Open() -> void:
	if visible:
		$AnimationPlayer.play("AbrirCofre")
		if playerRef.items_en_mano.size() < 3 and cantidad_almacenada > 0: #si hay espacio en las manos de player
			if playerRef.items_en_mano.find(material_almacenado) == -1:
				playerRef.recibirObjeto(material_almacenado)
				cantidad_almacenada -= 1
				GlobalRecursos.actualizar_mineral(material_almacenado, -1)
			# +1 al arreglo de items en las manos del jugador
			elif playerRef.items_en_mano.has(material_almacenado): 
				#si el jugador tiene en sus manos el item del cofre
				playerRef.darUnObjeto(material_almacenado)
				cantidad_almacenada += 1
				GlobalRecursos.actualizar_mineral(material_almacenado, 1)
				
		elif playerRef.items_en_mano.size() <= 3:
			if playerRef.items_en_mano.has(material_almacenado): 
				#si el jugador tiene en sus manos el item del cofre
				playerRef.darUnObjeto(material_almacenado)
				cantidad_almacenada += 1
				GlobalRecursos.actualizar_mineral(material_almacenado, 1)

# Señales

func _on_body_entered(body : Node2D):
	if body is Player:
		popup.visible = true
		playerRef = body
		isPlayerHere = true




func _on_body_exited(body):
	if body is Player:
		popup.visible = false
		isPlayerHere = false
