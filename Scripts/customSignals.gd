extends Node

class_name CustomSignals

signal change_level

static var inst = null

static func GetInstance() -> CustomSignals:
	if inst == null:
		inst = CustomSignals.new()
	return inst

func EmitChangeLevelSignal() -> void:
	change_level.emit()

func ConnectToChangeLevel(callback: Callable) -> void:
	change_level.connect(callback)
