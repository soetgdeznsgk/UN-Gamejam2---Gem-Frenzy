extends CharacterBody2D
class_name Cliente

const SPEED = 50.0
var dir = 1
var esperando = true
var moviendo = true

var posiblesTexturas = ["res://Sprites/Mapa/clientes/cliente1 14x19.png","res://Sprites/Mapa/clientes/cliente2 14x19.png"]
var textura
func _ready() -> void:
	$AnimationPlayer.play("caminar")
	var selec = posiblesTexturas.pick_random()
	textura = load(selec)
	$Sprite2D.texture = textura

func _physics_process(_delta: float) -> void:
	if $RayCast2D.is_colliding():
		if esperando:
			moviendo = false
			$AnimationPlayer.play("RESET")
	if esperando == false:
		dir = -1
		moviendo = true
		await get_tree().create_timer(3).timeout
		queue_free()
	velocity = Vector2 (dir, 0) * SPEED
	if moviendo:
		move_and_slide()
