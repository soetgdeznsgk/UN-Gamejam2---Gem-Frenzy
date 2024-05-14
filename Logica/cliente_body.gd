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
		await get_tree().create_timer(5).timeout
		queue_free()
		
var haPedido := false
var moviendo = true

var posiblesTexturas = ["res://Sprites/Mapa/clientes/cliente1 14x19.png",
"res://Sprites/Mapa/clientes/cliente2 14x19.png",
"res://Sprites/Mapa/clientes/Clientepelinaranja.png",
"res://Sprites/Mapa/clientes/Clientepelinegra.png",
"res://Sprites/Mapa/clientes/Clientepelirosa.png",
"res://Sprites/Mapa/clientes/00_variacion clientes 14x19.png",
"res://Sprites/Mapa/clientes/01_variacion clientes 14x19.png",
"res://Sprites/Mapa/clientes/02_variacion clientes 14x19.png",
"res://Sprites/Mapa/clientes/03_variacion clientes 14x19.png",
"res://Sprites/Mapa/clientes/04_variacion clientes 14x19.png",
"res://Sprites/Mapa/clientes/05_variacion clientes 14x19.png",
"res://Sprites/Mapa/clientes/cliente zen 14x23 px.png"]
var textura

func _ready() -> void:
	$AnimationPlayer.play("caminar")
	var selec = posiblesTexturas.pick_random()
	textura = load(selec)
	$Sprite2D.texture = textura
	GlobalTiempo.finalizarDia.connect(fin_dia)
	OrderManager.orden_exitosa.connect(se_fue_feliz)

func _physics_process(_delta: float) -> void:
	if $RayCast2D.is_colliding():
		if esperando:
			moviendo = false
			$AnimationPlayer.play("RESET")
			if not haPedido:
				OrderManager._on_new_customer(self)
				$AudioNuevaOrden.pitch_scale = randf_range(1.10,1.2)
				$AudioNuevaOrden.play(0)
				haPedido = true
	else:
		moviendo = true
		
		
	velocity = Vector2 (dir, 0) * SPEED
	if moviendo:
		move_and_slide()

func fin_dia():
	esperando = false

func se_fue_bravo():
	$Lb_money.text = "+0"
	$AnimMoney.play("fallo")
	
func se_fue_feliz(orden : OrderGem):
	if orden.cliente_asociado == self:
		@warning_ignore("integer_division")
		# cada nivel de la mejora de dinero agrega 25% más al precio de cada receta +1
		var dinerobono=((orden.precio / 4) * GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.RecompensaMejorada])\
		 + (1 * GlobalMejoras.activas_mejoras[GlobalMejoras.nombre_mejoras.RecompensaMejorada])
		
		$Lb_money.text = "+" + str(orden.precio+dinerobono)
		
		if orden.precio+dinerobono<5:
			$CPUParticles2D.amount = 5
		
		elif orden.precio+dinerobono>5 and orden.precio+dinerobono<8:
			$CPUParticles2D.amount = 8
		
		elif orden.precio+dinerobono>8:
			$CPUParticles2D.amount = 10
		
		$AnimMoney.play("exitoso")
