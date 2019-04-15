extends KinematicBody2D

onready var timer = $timer

var walk_dir : Vector2
var walk_speed = 350
var face_dir : Vector2
var tp_distance = 300

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT:
			teleport(event.global_position)

func _process(delta):
	if (get_global_mouse_position() - self.global_position) != Vector2.ZERO:
		face_dir = get_global_mouse_position() - self.global_position
	self.rotation = face_dir.angle() - PI/2

func _physics_process(delta):
	walk_dir = Vector2.ZERO
	if Input.is_action_pressed("walk_up"):
		walk_dir += Vector2.UP
	if Input.is_action_pressed("walk_down"):
		walk_dir += Vector2.DOWN
	if Input.is_action_pressed("walk_left"):
		walk_dir += Vector2.LEFT
	if Input.is_action_pressed("walk_right"):
		walk_dir += Vector2.RIGHT
	move_and_slide(walk_dir.normalized()*walk_speed)

func teleport(pos):
	if (!timer.time_left):
		$"..".spawn_tp_part()
		var rot = self.rotation
		self.position += (pos - self.position).clamped(tp_distance)
		self.rotation = rot
		$"..".spawn_tp_part()
		timer.start()
	