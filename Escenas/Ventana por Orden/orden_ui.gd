extends Control

@export var Dimension := 32

@onready var pb = $VBoxContainer/ProgressBar
var orden_logica : Order
@onready var cambiadorDeColor = StyleBoxFlat.new()

func _ready():
	cambiadorDeColor.bg_color = Color("008000")
	pb.add_theme_stylebox_override("fill", cambiadorDeColor)
	
func _physics_process(delta):
	pb.value = orden_logica.get_time_left()
	if pb.value == 20:
		cambiadorDeColor.bg_color = Color("FFFF00")
		
	elif pb.value == 10:
		cambiadorDeColor.bg_color = Color("FF0000")
		

func setOrden(orden : Order) -> void:
	orden_logica = orden
	add_child(orden)
	#print("todo gud ata aca")
	for i in range(orden.requirements.size()):
		var spritePath = OrderManager.SpritesMaterialesPaths.get(orden.requirements[i])
		var t := TextureRect.new()
		
		t.texture = load(spritePath)
		t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		t.stretch_mode = TextureRect.STRETCH_SCALE
		t.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		t.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		t.custom_minimum_size = Vector2(Dimension, Dimension)
		
		$VBoxContainer/HBoxContainer.add_child(t)
		
	

	
