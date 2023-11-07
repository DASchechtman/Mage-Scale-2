extends Node

var __child_nodes: Array[Callable] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in __child_nodes:
		add_child(i.call())

## Param -> obj: Callable() -> Node
## Return -> void
func AddChild(obj: Callable):
	__child_nodes.append(obj)
