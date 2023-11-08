extends Node

var __child_nodes: Array[Callable] = []
var __children_loaded := false

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in __child_nodes:
		add_child(i.call())
	__children_loaded = true

## Param -> obj: Callable() -> Node
## Return -> void
func AddChild(obj: Callable):
	if __children_loaded:
		add_child(obj.call())
	else:
		__child_nodes.append(obj)
