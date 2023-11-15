extends Node2D

func ChangeLevel():
	get_parent().ChangeLevel()

func Connect(callback: Callable):
	get_parent().Connect(callback)

func MakeInvisible():
	self.visible = false

func _process(delta):
	for i in get_children():
		if "Process" in i:
			i.Process(delta, self.visible)
