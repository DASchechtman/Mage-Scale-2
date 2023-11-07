extends Sprite2D


var x_speed: float = 0
var y_speed: float = 0

@onready var _projectile := preload("res://Prefabs/earth.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	_projectile.position = Vector2.ZERO
	get_parent().add_child(_projectile)
	pass # Replace with function body.

func _init():
	pass

func _input(event: InputEvent):
	if event.is_action_pressed("ui_right") or event.is_action_released("ui_right"):
		x_speed = ___SetSpeed("ui_right", event)
	
	if event.is_action_pressed("ui_left") or event.is_action_released("ui_left"):
		x_speed = -___SetSpeed("ui_left", event)
	
	if event.is_action_pressed("ui_up") or event.is_action_released("ui_up"):
		y_speed = -___SetSpeed("ui_up", event)
	
	if event.is_action_pressed("ui_down") or event.is_action_released("ui_down"):
		y_speed = ___SetSpeed("ui_down", event)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.position.x += x_speed
	self.position.y += y_speed


func ___SetSpeed(dir: String, event: InputEvent):
	if event.is_action_pressed(dir):
		return 1
	elif event.is_action_released(dir):
		return 0
	return 0
