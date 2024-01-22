extends CharacterBody2D

@onready var initialPos = position
var dir = 1
@onready var anim = $AnimationPlayer
@export var gatoPower : int
enum status {
	Camina,
	Sentado,
	Lamiendo,
	Durmiendo
}
var currentStatus = status.Sentado
var prevStatus
func _ready() -> void:
	GlobalMejoras.mejora_cambiada.connect(nuevo_gato)
	initialPos.x += 40
	

func nuevo_gato():
	var gatos = GlobalMejoras.activas_mejoras[5]
	if gatoPower < gatos:
		visible = true
		currentStatus = status.Sentado
		anim.play("Sentado")
		$Timer.start(2)

func _process(delta: float) -> void:
	if currentStatus == status.Camina:
		var coll = move_and_collide(Vector2(dir*0.45,0))

func check_status():
	prevStatus = currentStatus
	var ran_num = randf()
	if ran_num < 0.25:
		if prevStatus != status.Camina:
			$Timer.start(2.2)
			currentStatus = status.Camina
			anim.play("Camina")
			if position.x - initialPos.x < 32:
				dir = 1
				$Sprite2D.scale.x = 1
			elif position.x - initialPos.x > 32:
				dir = -1
				$Sprite2D.scale.x = -1
		else:
			$Timer.start(3)
			currentStatus = status.Sentado
			anim.play("Sentado")
	if ran_num > 0.25 and ran_num < 0.5:
		$Timer.start(8)
		currentStatus = status.Durmiendo
		anim.play("Acostado")
	if ran_num > 0.5 and ran_num < 0.75:
		$Timer.start(5)
		currentStatus = status.Lamiendo
		anim.play("Lamiendo")
	if ran_num > 0.75:
		$Timer.start(4)
		currentStatus = status.Sentado
		anim.play("Sentado")

func _on_timer_timeout() -> void:
	check_status()
