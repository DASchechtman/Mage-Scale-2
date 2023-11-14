extends CharacterBody2D

var __CAMERA: Camera2D
var __AREA: Area2D

func _ready():
	__CAMERA = $Camera2D
	__AREA = $Area2D
	__CAMERA.make_current()
	__AREA.connect("body_entered", _on_body_entered)

func _process(_delta):
	var dir = null
	if Input.is_action_pressed("ui_up"):
		dir = Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		dir = Vector2(0, 1)
	if Input.is_action_pressed("ui_left"):
		dir = Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		dir = Vector2(1, 0)
	
	if dir == null:
		return
	
	move_and_collide(dir)

func __CheckInput(event: InputEvent, dir: String, default: float):
	if event.is_action_pressed(dir):
		return 1
	elif event.is_action_released(dir):
		return 0
	return default

func _on_body_entered(_body: Node):
	print("%s hit" % _body.to_string())
