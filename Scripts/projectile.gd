extends Node

@export_group("projectile props")

@export_range(1, 4)
var speed: int
@export var scale: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().create_timer(2.0).connect("timeout", _on_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x += 100 * delta

func _on_timeout():
	queue_free()

func InitOnLoad():
	var points = 0
	for i in range(scale.get_child_count()):
		var node := scale.get_child(i)
		if node == null or not is_instance_of(node, TextureProgressBar):
			continue
		
		if i+1 != speed and node.value > 0:
			points += 1
			node.value -= 1
	scale.get_child(speed-1).value += points
