extends Node2D

@export var material_almacenado : int
var cantidad_almacenada := 0:
	get:
		return cantidad_almacenada
	set(val):
		cantidad_almacenada = val
		
@onready var popup := $Spr_up_key_ladder
var isPlayerHere := false
var playerRef

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isPlayerHere:
		if Input.is_action_just_pressed("ui_up"):
			Open()
	

# Llamadas

func Open() -> void:
	$AnimationPlayer.play("AbrirCofre")
	if true: #si hay espacio en las manos de player
		cantidad_almacenada -= 1
		# +1 al arreglo de items en las manos del jugador
	elif true: #si el jugador tiene en sus manos el item del cofre
		cantidad_almacenada += 1
		# -1 al arreglo de items en las manos del jugador
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
