extends Node

func _ready():
	if G.Settings.get_value("language", "language", "") == "":
		G.is_language_selected = false
		get_tree().change_scene_to_file("res://Language.tscn")
	else:
		G.is_language_selected = true
		get_tree().change_scene_to_file("res://Menu.tscn")
	
