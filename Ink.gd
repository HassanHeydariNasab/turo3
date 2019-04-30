extends Area2D

onready var Hide = $Hide
onready var x2 = $x2
onready var x2_Label = $x2/Label
onready var x2_FadeIn = $x2/FadeIn
onready var x2_FadeOut = $x2/FadeOut


var ink = 100
var multiply_by = 1
var can_multiply = false


func _ready():
	if G.Main.color == "ffffff":
		get_node("Look").set_color("ffffff")
	if randi() % 4 == 0:
		can_multiply = true


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
	G.Main.ink += (self.ink * multiply_by)
	queue_free()


func _on_Ink_area_entered( area ):
	if area.get_collision_layer_bit(1) == true:
		queue_free()


func _on_x2_body_entered(body):
	shape_owner_clear_shapes(1)
	if (not x2_Label.is_visible_in_tree()) and can_multiply:
		multiply_by = 2
		x2_Label.show()
		x2_FadeIn.interpolate_property(x2_Label, "modulate",
			Color("00ffffff"), Color("ffffffff"), 0.3,
			Tween.TRANS_SINE, Tween.EASE_OUT
		)
		x2_FadeOut.interpolate_property(x2_Label, "modulate",
			Color("ffffffff"), Color("00ffffff"), 0.3,
			Tween.TRANS_SINE, Tween.EASE_IN, 2.3+rand_range(0, 1)
		)
		x2_FadeIn.start()
		x2_FadeOut.start()


func _on_FadeOut_tween_completed(object, key):
	multiply_by = 1
	x2.queue_free()


func _on_FadeIn_tween_completed(object, key):
	G.Main.D6_pizzicato.play()
