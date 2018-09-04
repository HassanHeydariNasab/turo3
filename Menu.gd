extends Control

onready var Red = $Red
onready var Amber = $Amber
onready var Green = $Green
onready var Blue = $Blue
onready var Violet = $Violet
onready var Gray = $Gray
onready var Multicolor = $Multicolor

onready var White = $White
onready var Black = $Black

onready var BG = $BG

func _init():
	var language = G.Settings.get_value("language", "language")
	if TranslationServer.get_locale() != language:
		TranslationServer.set_locale(language)

func _ready():
	get_tree().set_auto_accept_quit(false)
	$Enter_sound.set("playing", G.Settings.get_value("audio", "sounds", true))
	get_node(G.Settings.get_value("color", "bgcolor", "Gray")).set_pressed(true)
	get_node(G.Settings.get_value("color", "color", "Black")).set_pressed(true)
	BG.set_color(G.colors[G.Settings.get_value("color", "bgcolor", "Gray")])

func _on_Play_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_Language_pressed():
	get_tree().change_scene("res://Language.tscn")

func _on_Settings_pressed():
	get_tree().change_scene("res://Settings.tscn")

func _on_About_pressed():
	get_tree().change_scene("res://About.tscn")

func _on_Exit_pressed():
	get_tree().quit()

func _on_Red_pressed():
	G.Settings.set_value("color", "bgcolor", "Red")
	G.Settings.save(G.settings_file)
	BG.set_color(G.colors[G.Settings.get_value("color", "bgcolor", "Gray")])
	Red.set_pressed(true)
	Amber.set_pressed(false)
	Green.set_pressed(false)
	Blue.set_pressed(false)
	Violet.set_pressed(false)
	Gray.set_pressed(false)
	Multicolor.set_pressed(false)

func _on_Amber_pressed():
	G.Settings.set_value("color", "bgcolor", "Amber")
	G.Settings.save(G.settings_file)
	BG.set_color(G.colors[G.Settings.get_value("color", "bgcolor", "Gray")])
	Red.set_pressed(false)
	Amber.set_pressed(true)
	Green.set_pressed(false)
	Blue.set_pressed(false)
	Violet.set_pressed(false)
	Gray.set_pressed(false)
	Multicolor.set_pressed(false)

func _on_Green_pressed():
	G.Settings.set_value("color", "bgcolor", "Green")
	G.Settings.save(G.settings_file)
	BG.set_color(G.colors[G.Settings.get_value("color", "bgcolor", "Gray")])
	Red.set_pressed(false)
	Amber.set_pressed(false)
	Green.set_pressed(true)
	Blue.set_pressed(false)
	Violet.set_pressed(false)
	Gray.set_pressed(false)
	Multicolor.set_pressed(false)

func _on_Blue_pressed():
	G.Settings.set_value("color", "bgcolor", "Blue")
	G.Settings.save(G.settings_file)
	BG.set_color(G.colors[G.Settings.get_value("color", "bgcolor", "Gray")])
	Red.set_pressed(false)
	Amber.set_pressed(false)
	Green.set_pressed(false)
	Blue.set_pressed(true)
	Violet.set_pressed(false)
	Gray.set_pressed(false)
	Multicolor.set_pressed(false)

func _on_Violet_pressed():
	G.Settings.set_value("color", "bgcolor", "Violet")
	G.Settings.save(G.settings_file)
	BG.set_color(G.colors[G.Settings.get_value("color", "bgcolor", "Gray")])
	Red.set_pressed(false)
	Amber.set_pressed(false)
	Green.set_pressed(false)
	Blue.set_pressed(false)
	Violet.set_pressed(true)
	Gray.set_pressed(false)
	Multicolor.set_pressed(false)

func _on_Gray_pressed():
	G.Settings.set_value("color", "bgcolor", "Gray")
	G.Settings.save(G.settings_file)
	BG.set_color(G.colors[G.Settings.get_value("color", "bgcolor", "Gray")])
	Red.set_pressed(false)
	Amber.set_pressed(false)
	Green.set_pressed(false)
	Blue.set_pressed(false)
	Violet.set_pressed(false)
	Gray.set_pressed(true)
	Multicolor.set_pressed(false)

func _on_Multicolor_pressed():
	G.Settings.set_value("color", "bgcolor", "Multicolor")
	G.Settings.save(G.settings_file)
	BG.set_color(G.colors[G.Settings.get_value("color", "bgcolor", "Gray")])
	Red.set_pressed(false)
	Amber.set_pressed(false)
	Green.set_pressed(false)
	Blue.set_pressed(false)
	Violet.set_pressed(false)
	Gray.set_pressed(false)
	Multicolor.set_pressed(true)

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
