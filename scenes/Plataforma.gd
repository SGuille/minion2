extends StaticBody2D

var can_move_up = false
var can_move_down = false
var bodies = []
var plataformas_a_mover = []
var primary = true
var chains

func _ready():
	chains = get_parent().get_node("Chains")
	
func _process(delta):
	if can_move_up:
		if primary:
			position.y += 0.3
			for p in plataformas_a_mover:
				p.position.y -= 0.3
	if can_move_down:
		if primary:
			position.y -= 0.3
			for p in plataformas_a_mover:
				p.position.y += 0.3

func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.name.begins_with("Box") && !bodies.has(body.name) && primary:
		bodies.append(body.name)
		can_move_up = true
		$Up.start()
		if chains != null: chains.move()

func _on_Area2D_body_shape_exited(body_id, body, body_shape, area_shape):
	if !can_move_up && body.name.begins_with("Box") && bodies.has(body.name) && primary:
		bodies.erase(body.name)
		can_move_down = true
		$Down.start()
		
func _on_Up_timeout():
	can_move_up = false
	if chains != null: chains.stop()

func _on_Down_timeout():
	can_move_down = false
