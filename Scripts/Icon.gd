extends Sprite2D

var step: int = 0
var switch: bool = true
const RANGE := 100
const INC := 400

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if step == RANGE:
		switch = false
	elif step == RANGE * -1:
		switch = true
	
	match switch:
		true:
			self.position.x += (INC * delta)
			step += 1
		false:
			self.position.x -= (INC * delta)
			step -= 1
	

