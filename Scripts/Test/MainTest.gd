extends Node

var __CAMERA: Camera2D
var __TIMER: Timer
var __MANAGED_SCENE := ManagedScene.GetInst()
var __CUSTOM_SIGNAL := CustomSignals.GetInstance()

func _ready():
	__CAMERA = $Camera2D
	__TIMER = $Timer
	__MANAGED_SCENE.AddReadyCallback(self, OnReady)
	__MANAGED_SCENE.AddExitCallback(self, OnExit)

func OnReady():
	__CAMERA.make_current()
	__TIMER.connect("timeout", __OnTimeOut)
	__TIMER.start(5)

func OnExit():
	__TIMER.stop()
	__TIMER.disconnect("timeout", __OnTimeOut)

func __OnTimeOut():
	__CUSTOM_SIGNAL.EmitChangeLevelSignal()

