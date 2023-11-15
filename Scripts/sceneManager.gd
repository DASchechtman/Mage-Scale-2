extends Node

@onready var cur_level = []


func _ready():
	CustomSignals.GetInstance().ConnectToChangeLevel(_change_level)
	cur_level.append($Overworld)

func _change_level():
	_get_last_el().MakeInvisible()
	cur_level.append(load("res://Scenes/test.tscn").instantiate())
	add_child(_get_last_el())

func _get_last_el():
	return cur_level[len(cur_level)-1]
