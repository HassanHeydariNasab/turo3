extends Control


func _ready():
	$Sounds.set_pressed(G.Settings.get_value("audio", "sounds", true))
	$Music.set_pressed(G.Settings.get_value("audio", "music", true))
	$BG.set_color(G.colors[G.Settings.get_value("color", "bgcolor", "Gray")])
	$Enter_sound.set("playing", G.Settings.get_value("audio", "sounds", true))

func _on_Sounds_toggled( b ):
	G.Settings.set_value("audio", "sounds", b)
	G.Settings.save(G.settings_file)

func _on_Music_toggled( b ):
	G.Settings.set_value("audio", "music", b)
	G.Settings.save(G.settings_file)

func _on_Back_pressed():
	get_tree().change_scene("res://Menu.tscn")
