extends Control


func _on_Code_pressed():
	OS.shell_open("https://github.com/HassanHeydariNasab/turo3")

func _on_Attributions_pressed():
	OS.shell_open("https://github.com/HassanHeydariNasab/turo3/blob/master/ATTRIBUTIONS.md")

func _on_Back_pressed():
	get_tree().change_scene_to_file("res://Menu.tscn")
