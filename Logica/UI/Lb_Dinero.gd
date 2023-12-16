extends Label
@onready var Lb_dinero = %Lb_Dinero
var strDinero : String
@onready var animplayer = $"../TextureDinero/AnimationPlayer"

func _ready() -> void:
	GlobalRecursos.cambioDinero.connect(actualizarDinero)
	Lb_dinero.self_modulate = Color("ffffff")

func actualizarDinero(dinero):
	if dinero < 10 and dinero >= 0:
		strDinero = '00' + str(dinero)
	if dinero < 100 and dinero >= 10:
		strDinero = '0' + str(dinero)
	if dinero >=  100:
		strDinero = str(strDinero)
	if dinero < 0:
		strDinero = str(dinero)
		Lb_dinero.self_modulate = Color("ff2016")
	Lb_dinero.text = strDinero 
	animplayer.play("newmoney")
