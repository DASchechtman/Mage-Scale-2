extends Sprite2D

var x_speed: float = 0
var y_speed: float = 0

@onready var _projectile_earth := preload("res://Prefabs/earth.tscn")
@onready var _projectile_water := preload("res://Prefabs/water.tscn")
@onready var _projectile_fire := preload("res://Prefabs/fire.tscn")
@onready var _projectile_air := preload("res://Prefabs/air.tscn")
@onready var _scale = get_tree().get_root().get_node("Node/Scale")

var timer: Timer

var create_projectile: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print(_scale)
	timer = get_child(0) as Timer
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
	if Input.is_physical_key_pressed(KEY_SPACE) and timer.is_stopped():
		__Fire()
		timer.start()

func __Fire():
	get_parent().AddChild(__Shoot())

func ___SetSpeed(dir: String, event: InputEvent):
	if event.is_action_pressed(dir):
		return 1
	elif event.is_action_released(dir):
		return 0
	return 0

func __CreateProjectile(projectile_inst: Projectile):
	var projectile := projectile_inst
	projectile.AlterScale(.5)
	var projectile_width = projectile.GetWidth() / 2.0
	var player_width = get_texture().get_width() / 2.0
	projectile.InitOnLoad(_scale)
	projectile.SetPositionByCoord(self.position.x + player_width + projectile_width, self.position.y)
	return projectile

func __Shoot() -> Callable:
	var projectile_id = (randi() % 4) + 1
	var projectile_inst = null

	match(projectile_id):
		1: projectile_inst = _projectile_earth.instantiate()
		2: projectile_inst = _projectile_water.instantiate()
		3: projectile_inst = _projectile_fire.instantiate()
		4: projectile_inst = _projectile_air.instantiate()
	
	return func() -> Node:
		return __CreateProjectile(projectile_inst as Projectile)
