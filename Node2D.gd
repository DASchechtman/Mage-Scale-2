extends Node2D

var secs: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var x := 1
	while x < 10:
		print(x)
		x += 1
	print("hello world")

func _process(delta: float):
	if secs >= 5:
		secs = 0
		print("1 minute has passed")
	else:
		secs += delta
