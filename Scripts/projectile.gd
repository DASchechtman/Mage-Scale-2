extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().create_timer(2.0).connect("timeout", _on_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x += 100 * delta

func _on_timeout():
	queue_free()
