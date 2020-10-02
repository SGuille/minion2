extends RigidBody2D

var player
var levitating = false
var pos
var push = false
var mouse_entered = false
export var color = Color.white
	
func _ready():
	modulate = color
	player = get_parent().get_node('Player')

func _physics_process(delta):
	if (Input.is_action_pressed("click") and mouse_entered):
		levitate()
	
	if (levitating):
		_start_levitation()	
		_push_box()
			
func levitate():
	var distance = player.global_position.distance_to(position)
	
	if (distance < 130):
		pos = (position - player.get_global_position()).normalized() * 150
		levitating = true
		
func _start_levitation():
	var y = global_position.y 	
	
	if (y >= 200):	
		set_axis_velocity(Vector2(0, -100))
	else:
		mode = RigidBody2D.MODE_KINEMATIC
		levitating = false	
		push = true
		
func _push_box():
	if (!levitating and push):
		yield(get_tree().create_timer(0.3), "timeout")
		mode = RigidBody2D.MODE_CHARACTER			
		apply_central_impulse(pos)
		push = false

func _on_Box_mouse_entered():
	mouse_entered = true
	modulate = Color.darkmagenta

func _on_Box_mouse_exited():
	mouse_entered = false
	modulate = color
