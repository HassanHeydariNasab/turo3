extends Control


onready var White = $White
onready var Black = $Black

func _ready():
	get_tree().set_auto_accept_quit(false)
	$Sounds.set_pressed(G.Settings.get_value("audio", "sounds", true))
	$Music.set_pressed(G.Settings.get_value("audio", "music", true))
	get_node(G.Settings.get_value("color", "color", "Black")).set_pressed(true)

func _on_Sounds_toggled( b ):
	G.Settings.set_value("audio", "sounds", b)
	G.Settings.save(G.settings_file)

func _on_Music_toggled( b ):
	G.Settings.set_value("audio", "music", b)
	G.Settings.save(G.settings_file)

func _on_Back_pressed():
	get_tree().change_scene("res://Menu.tscn")


func _on_Black_pressed():
	G.Settings.set_value("color", "color", "Black")
	G.Settings.save(G.settings_file)
	White.set_pressed(false)
	Black.set_pressed(true)

func _on_White_pressed():
	G.Settings.set_value("color", "color", "White")
	G.Settings.save(G.settings_file)
	White.set_pressed(true)
	Black.set_pressed(false)

func _on_Language_pressed():
	get_tree().change_scene("res://Language.tscn")

func _on_About_pressed():
	get_tree().change_scene("res://About.tscn")
