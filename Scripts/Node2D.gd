extends Node2D

var secs: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var x = {}
	var _y: Array[String] = []
	x["4"] = "hello"
	print(x["4"])
	print(_y)

func _process(delta: float):
	_PrintAfter(5, delta, "5 seconds have passed")

func _StrArr(x: Array[int]) -> Array[String]:
	var y: Array[String] = []
	for i in x:
		y.append(str(i))
	return y
	

func _PrintAfter(seconds: int, delta: float, message: String):
	if secs >= seconds:
		secs = delta
		print(message)
	else:
		secs += delta
