extends Control
@export var APtutorial:AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalTuto.tutorial:
		GlobalRecursos.actualizar_mineral(0,2)
		GlobalRecursos.actualizar_mineral(3,2)
		self.visible=true
		APtutorial.play("pancha_receta")

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
