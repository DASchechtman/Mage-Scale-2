extends Sprite2D

var step: int = 0
var switch: bool = true
var RANGE := 100
const INC := 400

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if step == RANGE:
		RANGE = -RANGE
	
	match RANGE:
		100:
			self.position.x += (INC * delta)
			step += 1
		-100:
			self.position.x -= (INC * delta)
			step -= 1
	

