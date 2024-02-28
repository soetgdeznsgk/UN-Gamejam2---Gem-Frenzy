extends Control
@export var APtutorial:AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalTuto.tutorial:
		GlobalRecursos.actualizar_mineral(0,2)
		GlobalRecursos.actualizar_mineral(3,2)
		#GlobalTuto.actualizarrecursostutorial.emit()
		#print("señal emitida")
		self.visible=true
		APtutorial.play("pancha_receta")
	pass # Replace with function body.

func animar_taladrando():
	
	APtutorial.play("pancha_taladrando")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		APtutorial.play("receta_to_entrega")
	pass
