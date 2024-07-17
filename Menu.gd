extends Control


func _init():
	pass

func _ready():
	get_tree().set_auto_accept_quit(false)

func _on_Play_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_Settings_pressed():
	get_tree().change_scene_to_file("res://Settings.tscn")

func _on_Exit_pressed():
	get_tree().quit()
