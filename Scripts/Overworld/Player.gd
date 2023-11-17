extends CharacterBody2D

var __CAMERA: Camera2D
var __AREA: Area2D
var __AUDIO: AudioStreamPlayer
var __CUSTOM_SIGNAL := CustomSignals.GetInstance()
var __managed_scene := ManagedScene.GetInst()
var __area_entered := ""
var __x := 0

func _ready():
	__CAMERA = $Camera2D
	__AREA = $Area2D
	__AUDIO = $AudioStreamPlayer
	__CAMERA.make_current()
	__AREA.connect("body_entered", _on_body_entered)
	__AREA.connect("body_exited", _on_body_exit)
	__AUDIO.connect("finished", _loop_audio)
	__managed_scene.AddReadyCallback(self, OnReady)
	__managed_scene.AddProcessCallback(self, OnProcess)
	__managed_scene.AddExitCallback(self, OnExit)
	__managed_scene.AddInputCallback(self, OnInput)

func OnProcess(_delta: float):
	
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


func OnReady():
	__AUDIO.stream = load("res://Assets/audio/1_-_sample.mp3")
	__AUDIO.play()
	__CAMERA.make_current()

func OnExit():
	_stop()

func OnInput(event: InputEvent):
	if event.is_action_pressed("ui_left"):
		print("moving left")
	elif event.is_action_pressed("ui_right"):
		print("moving right")
	elif event.is_action_pressed("ui_up"):
		print("moving up")
	elif event.is_action_pressed("ui_down"):
		print("moving down")


func _call_signal():
	__CUSTOM_SIGNAL.EmitChangeLevel()

func _stop():
	__AUDIO.stop()

func __CheckInput(event: InputEvent, dir: String, default: float):
	if event.is_action_pressed(dir):
		return 1
	elif event.is_action_released(dir):
		return 0
	return default

func _loop_audio():
	__AUDIO.play()

func _on_body_entered(_body: Node):
	if _body.name == "Grass Area" or _body.name == "Water Area" or _body.name == "Sky Area":
		__area_entered = _body.name
	elif _body.get_groups().has("enemy"):
		__CUSTOM_SIGNAL.EmitChangeLevelSignal()

func _on_body_exit(_body: Node):
	_ChangeMusic()
	
func _ChangeMusic():
	var url: String = ""
	
	match __area_entered:
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
