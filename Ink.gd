extends Area2D

onready var Hide = $Hide

var ink = 100

func _ready():
	if G.Main.color == "ffffff":
		get_node("Look").set_color("ffffff")

func _on_Ink_body_entered( body ):
	shape_owner_clear_shapes(0)
	if ink > 60:
		G.Main.Ink5_sound.set("playing", G.Settings.get_value("audio", "sounds", true))
	elif ink > 50:
		G.Main.Ink4_sound.set("playing", G.Settings.get_value("audio", "sounds", true))
	elif ink > 40:
		G.Main.Ink3_sound.set("playing", G.Settings.get_value("audio", "sounds", true))
	elif ink > 30:
		G.Main.Ink2_sound.set("playing", G.Settings.get_value("audio", "sounds", true))
	elif ink <= 30:
		G.Main.Ink1_sound.set("playing", G.Settings.get_value("audio", "sounds", true))
	Hide.interpolate_property($Look, "color",
		Color("ffffff"), Color("00D500F9"), 0.25,
		Tween.TRANS_SINE, Tween.EASE_OUT
	)
	Hide.start()

func _on_Hide_tween_completed( object, key ):
	G.Main.ink += self.ink
	queue_free()

func _on_Ink_area_entered( area ):
	if area.get_collision_layer_bit(1) == true:
		queue_free()
