extends Node2D

var __CAMERA: Camera2D

func _ready():
	__CAMERA = $Camera2D
	__CAMERA.make_current()

func _process(_delta):
	if Input.is_action_pressed("ui_up"):
		position.y -= 1
	if Input.is_action_pressed("ui_down"):
		position.y += 1
	if Input.is_action_pressed("ui_left"):
		position.x -= 1
	if Input.is_action_pressed("ui_right"):
		position.x += 1

func __CheckInput(event: InputEvent, dir: String, default: float):
	if event.is_action_pressed(dir):
		return 1
	elif event.is_action_released(dir):
		return 0
	return default

