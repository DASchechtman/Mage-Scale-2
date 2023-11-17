extends Node

@onready var cur_level: Array[Node] = []
var __managed_scenes = ManagedScene.GetInst()
var __loaded_scenes: Dictionary = {}
var __cur_path := ""

func _ready():
	CustomSignals.GetInstance().ConnectToChangeLevel(_change_level)
	var node = $Overworld
	__cur_path = "res://Scenes/overworld.tscn"
	__loaded_scenes[__cur_path] = node
	__managed_scenes.RunReadyCallbacks(node)

func _process(delta):
	__managed_scenes.RunProcessCallbacks(__GetActiveScene(), delta)

func _input(event):
	__managed_scenes.RunInputCallbacks(__GetActiveScene(), event)

func _change_level():
	var scene = __GetActiveScene()
	__managed_scenes.RunExitCallbacks(scene)
	__ActivateScene(scene.GetNextScene())
	__managed_scenes.RunReadyCallbacks(__GetActiveScene())

func __GetActiveScene():
	if not __loaded_scenes.has(__cur_path): return Node.new()
	return __loaded_scenes[__cur_path]

func __ActivateScene(scene_path: String):
	var path = scene_path
	var scene = __GetActiveScene()
	if __loaded_scenes.has(path):
		var node = __loaded_scenes[path]
		__SetVisibility(scene, false)
		__SetVisibility(node, true)
	else:
		var node = load(path).instantiate()
		__SetVisibility(scene, false)
		__loaded_scenes[path] = node
		add_child(node)
	__cur_path = path

func __SetVisibility(node: Node, visible: bool):
	for child in node.get_children():
		__SetVisibility(child, visible)
	if "visible" in node: node.visible = visible
