extends CharacterBody2D
class_name Cliente

const SPEED = 50.0

var dir = 1
var esperando = true:
	set(value): #ésto se ejecuta cuando se le marque al cliente que ya no tiene que esperar más
		esperando = value
		dir = -1
		moviendo = true
		$Sprite2D.flip_h = true
		$AnimationPlayer.play("caminar")
		$CollisionShape2D.set_deferred("disabled", true)
		await get_tree().create_timer(3).timeout
		queue_free()
		
var haPedido := false
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
			if not haPedido:
				OrderManager._on_new_customer(self)
				haPedido = true
	else:
		moviendo = true
		
		
	velocity = Vector2 (dir, 0) * SPEED
	if moviendo:
		move_and_slide()
