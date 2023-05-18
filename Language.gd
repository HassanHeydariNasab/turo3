extends Control


func _ready():
	if not G.is_language_selected:
		get_tree().set_auto_accept_quit(false)

func _on_EO_pressed():
	G.Settings.set_value("language", "language", "eo")
	G.Settings.save(G.settings_file)
	G.is_language_selected = true
	get_tree().change_scene_to_file("res://Menu.tscn")

func _on_EN_pressed():
	G.Settings.set_value("language", "language", "en")
	G.Settings.save(G.settings_file)
	G.is_language_selected = true
	get_tree().change_scene_to_file("res://Menu.tscn")
