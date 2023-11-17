class_name ManagedScene

static var inst: ManagedScene = null

static func GetInst() -> ManagedScene:
	if inst == null:
		inst = ManagedScene.new()
	return inst


var __ready_callbacks: Dictionary = {}
var __process_callbacks: Dictionary = {}
var __exit_callbacks: Dictionary = {}
var __input_callbacks: Dictionary = {}

func AddReadyCallback(node: Node, callback: Callable) -> void:
	__AddCallBackToDict(node, __ready_callbacks, callback)

func AddProcessCallback(node: Node, callback: Callable) -> void:
	__AddCallBackToDict(node, __process_callbacks, callback)

func AddExitCallback(node: Node, callback: Callable) -> void:
	__AddCallBackToDict(node, __exit_callbacks, callback)

func AddInputCallback(node: Node, callback: Callable) -> void:
	__AddCallBackToDict(node, __input_callbacks, callback)

func RunReadyCallbacks(node: Node) -> void:
	__RunCallback(node, __ready_callbacks)

func RunProcessCallbacks(node: Node, delta: float) -> void:
	__RunCallback(node, __process_callbacks, [delta])

func RunExitCallbacks(node: Node) -> void:
	__RunCallback(node, __exit_callbacks)

func RunInputCallbacks(node: Node, input: InputEvent):
	__RunCallback(node, __input_callbacks, [input])

func __GetNodeAncestor(node: Node) -> Node:
	var cur := node
	var last_cur: Node = null
	while true:
		var parent := cur.get_parent()
		var cur_name = cur.name
		if parent == null or cur_name == "sceneManager": break
		last_cur = cur
		cur = parent
	return last_cur if last_cur != null else cur

func __AddCallBackToDict(node_key: Node, map: Dictionary, callback: Callable):
	var key = __GetNodeAncestor(node_key)
	if not map.has(key):
		map[key] = []
	map[key].append(callback)

func __RunCallback(node_key: Node, map: Dictionary, args: Array = []):
	if not map.has(node_key): return
	for callback in map[node_key]:
		if len(args) > 0:
			callback.callv(args)
			continue
		callback.call()
