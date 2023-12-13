extends Control

@export var Dimension := 32

@onready var pb = $VBoxContainer/ProgressBar
var orden_logica : Order
@onready var cambiadorDeColor = StyleBoxFlat.new()

func _ready():
	cambiadorDeColor.bg_color = Color("008000")
	pb.add_theme_stylebox_override("fill", cambiadorDeColor)
	
func _physics_process(_delta):
	pb.value = orden_logica.get_time_left()
	if pb.value == 20:
		cambiadorDeColor.bg_color = Color("FFFF00")
		
	elif pb.value == 10:
		cambiadorDeColor.bg_color = Color("FF0000")

func setOrden(orden : Order) -> void:
	orden_logica = orden
	add_child(orden)
	orden.out_of_time.connect(orden_out_of_time)
	
	var t = orden.requirements.size()
	for i in range(t):
		$VBoxContainer/HBoxContainer.get_child((i + t + 1) % t).frame = orden.requirements[i]
	$recetaSprite.frame = GlobalRecetas.encontrarReceta(orden.requirements) # revisar

# Señales

func orden_out_of_time():
	queue_free()

	
