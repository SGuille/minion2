extends Node2D

func _on_StartGame_pressed():
	$WelcomeHUD._hide()
	# Add the next level
	var next_level_resource = load("res://Level1.tscn")
	var next_level = next_level_resource.instance()
	add_child(next_level)
	if (!$BackgroundSound.playing && $WelcomeHUD/OptionsHUD.backgroundSound):
		$BackgroundSound.play()
	_show_player()
	
func _on_Menu_pressed():
	$GameOverHUD._hide()
	$GamerOverSound.stop()
	$WelcomeHUD._show()

func _show_player():
	#$Player.show()
	#$Player.position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	pass

func _on_Player_hit():
	$GamerOverSound.play()
	$BackgroundSound.stop()
	$GameOverHUD._show()
	_clean_all_elements()
	
func _clean_all_elements():
	var array = []
	for elements in array: _clean_elements(elements)
	$Player.hide()
	
func _clean_elements(elements):
	for element in elements:
			element.hide()
			element.set_deferred("disabled", true)
			element.queue_free()
