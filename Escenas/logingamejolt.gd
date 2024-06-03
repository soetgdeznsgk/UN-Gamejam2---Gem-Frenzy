extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameJoltHandler.logeadogamejolt:
		visible=false
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_close_login_pressed() -> void:
	self.visible=false
	pass # Replace with function body.


func _on_logearse_pressed() -> void:
	GameJolt.users_auth_completed.connect(auth_completed)
	var username= $VBoxContainer/username.text
	var gametoken=$VBoxContainer/gametoken.text
	GameJoltHandler.iniciar_sesion(username,gametoken)

	#print(GameJoltHandler.logeadogamejolt)
	pass # Replace with function body.
func auth_completed(response):
	print("Gamejolt logeado? ",response["success"])
	if response["success"]=="true":
		GameJoltHandler.logeadogamejolt=true
		$login_bien.visible=true
		await get_tree().create_timer(1).timeout
		visible=false
		GameJoltHandler.conectar_señales()
		#GameJoltHandler.check_achievement_unlocked("233328")
	else:
		GameJoltHandler.logeadogamejolt=false
		$login_error.visible=true
		await get_tree().create_timer(1).timeout
		$login_error.visible=false
		
