extends HBoxContainer
var textureSndOff = load("res://Sprites/UI/Icon_SoundOff.png")
var textureSndOn = load("res://Sprites/UI/Icon_SoundOn.png")
var sound:bool
# Called when the node enters the scene tree for the first time.
func _ready():
	var valoraudio=AudioServer.get_bus_volume_db(0)
	if valoraudio==0.067:
		$Btn_toggle_sound.icon= textureSndOff
		sound=false
	else:
		$Btn_toggle_sound.icon= textureSndOn
		sound=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_btn_toggle_sound_pressed():
	if sound:
		AudioServer.set_bus_volume_db(0,-72)
		$Btn_toggle_sound.icon=  textureSndOff
		sound=false
	else:
		AudioServer.set_bus_volume_db(0,0)
		$Btn_toggle_sound.icon=  textureSndOn
		sound=true# Replace with function body.
	pass # Replace with function body.


func _on_btn_home_pressed():
	get_tree().call_deferred("change_scene_to_file","res://Escenas/game_start.tscn")
	pass # Replace with function body.



	pass # Replace with function body.
