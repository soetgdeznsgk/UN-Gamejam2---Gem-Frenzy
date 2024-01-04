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
		strDinero = str(dinero)
	if dinero < 0 and dinero >= -9:
		strDinero = "-00" + str(abs(dinero))
		Lb_dinero.self_modulate = Color("ff2016")
	if dinero < -9 and dinero >= -99:
		strDinero = "-0" + str(abs(dinero))
		Lb_dinero.self_modulate = Color("ff2016")
	if dinero < -99:
		strDinero = "-" + str(abs(dinero))
		Lb_dinero.self_modulate = Color("ff2016")
	
	Lb_dinero.text = strDinero 
	animplayer.play("newmoney")
