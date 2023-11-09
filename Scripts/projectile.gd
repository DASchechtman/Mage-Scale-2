class_name Projectile
extends Node


static var __inst: Projectile = null

static func GetInstance() -> Projectile:
	if __inst == null:
		__inst = Projectile.new()
	return __inst

class Test:
	var test1: int = 0
	var test2: int = 0

@export_group("projectile props")

@export_range(1, 4)
var speed: int


var _magic_scale: Node2D
var _cur_scale: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().create_timer(2.0).connect("timeout", _on_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x += 100 * delta

func _on_timeout():
	queue_free()

func _AdjustScale() -> int:
	var points := 0
	for i in range(_magic_scale.get_child_count()):
		var node := _magic_scale.get_child(i)
		if node == null or not is_instance_of(node, TextureProgressBar):
			continue
		
		if i+1 != speed and node.value > 0:
			node.value -= 1
			points += 1
	return points


func InitOnLoad(scale: Node2D) -> void:
	_magic_scale = scale
	_magic_scale.get_child(speed-1).value += _AdjustScale()

func AlterScale(num: float) -> void:
	_cur_scale = num
	self.scale *= num

func SetPosition(pos: Vector2) -> void:
	self.position = pos

func SetPositionByCoord(x: float, y: float) -> void:
	self.position = Vector2(x, y)                          

func GetWidth() -> float:
	return self.texture.get_width() * _cur_scale

func GetHeight() -> float:
	return self.texture.get_height() * _cur_scale
