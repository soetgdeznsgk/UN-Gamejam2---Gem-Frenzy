extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_btn_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://intro_anim.tscn")


func _on_btn_instrucciones_pressed() -> void:
	pass # Replace with function body.


func _on_btn_creditos_pressed() -> void:
	pass # Replace with function body.
