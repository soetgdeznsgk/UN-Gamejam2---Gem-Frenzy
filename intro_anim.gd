extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("intro",-1,0.8,false)
	

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Escenas/MainJuego.tscn")

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		$AnimationPlayer.speed_scale = 3
	else:
		$AnimationPlayer.speed_scale = 0.8
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Escenas/MainJuego.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/MainJuego.tscn")
