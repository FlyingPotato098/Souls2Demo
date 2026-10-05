extends Control





var button_type = null



func _on_play_pressed() -> void:
	
	get_tree().change_scene_to_file("res://scenes/Game_/game.tscn")
	


func _on_options_pressed() -> void:
	
	get_tree().change_scene_to_file("res://scenes/UserInterface/options.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_fade_timer_timeout() -> void:

		get_tree().change_scene_to_file("res://scenes/Game_/game.tscn")
