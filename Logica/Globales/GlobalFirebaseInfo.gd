extends Node

var isAuth = false
var token
@onready var collection: FirestoreCollection = Firebase.Firestore.collection("TOP_PLAYERS")

func _ready() -> void:
	Firebase.Auth.login_anonymous()
	Firebase.Auth.signup_failed.connect(_on_failed)
	Firebase.Auth.signup_succeeded.connect(_on_succeed)
	
func _on_failed(auth_info):
	print("error", auth_info)

func _on_succeed(auth_info):
	print("Correcto: ")
	isAuth = true
	token = auth_info["idtoken"]

