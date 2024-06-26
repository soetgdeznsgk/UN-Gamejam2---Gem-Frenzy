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
	if GlobalTuto.tutorial and num_cofre==2:
		visible=false
		activo=false
# Llamadas

func Open() -> void:
	if visible and not playerRef.receta_en_mano:
		if playerRef.items_en_mano.size() < 3 and cantidad_almacenada > 0: #si hay espacio en las manos de player
			$AnimationPlayer.play("AbrirCofre")
			$AudioStreamPlayer.pitch_scale = randf_range(0.985, 1.1)
			$AudioStreamPlayer.play()
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
			return
				
		if playerRef.items_en_mano.size() <= 3 and \
			playerRef.items_en_mano.has(material_almacenado): 
				$AnimationPlayer.play("AbrirCofre")
				#si el jugador tiene en sus manos el item del cofre
				playerRef.darUnObjeto(material_almacenado)
				cantidad_almacenada += 1
				GlobalRecursos.actualizar_mineral(material_almacenado, 1)
				$AudioStreamPlayer.pitch_scale = randf_range(1,1.05)
				$AudioStreamPlayer.play()
				return
		# cuando no tiene nada
		if cantidad_almacenada == 0 and not playerRef.items_en_mano.has(material_almacenado):
			$AnimationPlayer.play("NoHay")
			if GlobalTuto.tutorial:
				cantidad_almacenada+=5
			$SP_nohay.play()
			return

				

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
