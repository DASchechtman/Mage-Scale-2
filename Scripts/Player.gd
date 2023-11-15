extends CharacterBody2D

var __CAMERA: Camera2D
var __AREA: Area2D
var __AUDIO: AudioStreamPlayer
var __CUSTOM_SIGNAL = CustomSignals.GetInstance()
var __x := 0

func _ready():
	__CAMERA = $Camera2D
	__AREA = $Area2D
	__AUDIO = $AudioStreamPlayer
	__CAMERA.make_current()
	__AREA.connect("body_entered", _on_body_entered)
	__AUDIO.connect("finished", _loop_audio)
	__CUSTOM_SIGNAL.ConnectToChangeLevel(_test)

func _call_signal():
	__CUSTOM_SIGNAL.EmitChangeLevel()

func _test():
	print("test")

func _stop():
	__AUDIO.stop()
	__CAMERA.set_current(false)

func Process(_delta: float, _should_run: bool):
	if not _should_run:
		_stop()
		return
	
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
	
	if move_and_collide(dir) != null:
		print("%s" % (__x + 1))
		__x += 1
		__CUSTOM_SIGNAL.EmitChangeLevelSignal()

func __CheckInput(event: InputEvent, dir: String, default: float):
	if event.is_action_pressed(dir):
		return 1
	elif event.is_action_released(dir):
		return 0
	return default

func _loop_audio():
	__AUDIO.play()

func _on_body_entered(_body: Node):
	var url: String = ""
	
	match _body.name:
		"Grass Area":
			url = "res://Assets/audio/1_-_sample.mp3"
		"Water Area":
			url = "res://Assets/audio/2_-_sample.mp3"
		"Sky Area":
			url = "res://Assets/audio/3_-_sample.mp3"
	
	if url == "": return
	
	__AUDIO.stop()
	__AUDIO.stream = load(url)
	__AUDIO.play()
