extends Node

var settings_file = "user://settings.cfg"
var Settings = ConfigFile.new()

var is_language_selected = true

var Main = null

var colors = {
	"Red":"E53935", "Amber":"FFB300",
	"Green":"43A047", "Blue":"1E88E5",
	"Violet":"8E24AA",
	"Black":"000000", "White":"ffffff",
}
var colors_order = ["Red", "Amber", "Green", "Blue", "Violet"]

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		if get_tree().get_current_scene().get_name() == "Menu":
			get_tree().quit()
		elif get_tree().get_current_scene().get_name() == "Language" and not G.is_language_selected:
			pass
		else:
			get_tree().change_scene_to_file("res://Menu.tscn")

func _ready():
	Settings.load(settings_file)
