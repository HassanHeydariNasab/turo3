extends Node

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()

var lingvo_elektita = false

var Radiko = null

var koloroj = {"Rugxa":"E53935", "Ambra":"FFB300",
				"Verda":"43A047", "Blua":"1E88E5",
				"Viola":"8E24AA", "Griza":"616161",
				"Nigra":"000000", "Blanka":"ffffff",
				"Multkolora":"616161"
			}
var multkoloroj = ["Rugxa", "Ambra", "Verda", "Blua", "Viola", "Griza"]

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		if get_tree().get_current_scene().get_name() == "Menuo":
			get_tree().quit()
		elif get_tree().get_current_scene().get_name() == "Lingvo" and not T.lingvo_elektita:
			pass
		else:
			get_tree().change_scene("res://Menuo.tscn")

func _ready():
	Agordejo.load(agordejo)

func get_layer_bit (korpo, bit):
	if korpo is KinematicBody2D or korpo is Area2D or\
	korpo is StaticBody2D:
		return korpo.get_collision_mask_bit(bit)
	elif korpo is TileMap:  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
		return korpo.get_collision_layer_bit(bit)
