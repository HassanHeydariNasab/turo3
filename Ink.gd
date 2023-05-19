extends Area2D

@onready var x2 = $x2
@onready var x2_Label = $x2/Label
var tween: Tween


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
	tween = create_tween()
	tween.tween_property($Look, "color",
		Color("D500F9"), 0.25,
	).from(Color("ffffff"))
	tween.tween_callback(_on_Hide_tween_completed)

func _on_Hide_tween_completed():
	G.Main.ink += (self.ink * multiply_by)
	queue_free()


func _on_Ink_area_entered( area ):
	if area.get_collision_layer_value(1) == true:
		queue_free()


func _on_x2_body_entered(body):
	shape_owner_clear_shapes(1)
	if (not x2_Label.is_visible_in_tree()) and can_multiply:
		multiply_by = 2
		x2_Label.show()
		tween = create_tween()
		tween.tween_property(x2_Label, "modulate", Color("ffffff",1), 0.3).from(
				Color("ffffff", 0))
		G.Main.D6_pizzicato.play()
		tween.tween_property(x2_Label, "modulate", Color("ffffff",0), 0.3).set_delay(
				2.3+randf_range(0, 1)).from(Color("ffffff",1))
		tween.tween_callback(_on_FadeOut_tween_completed)


func _on_FadeOut_tween_completed(object, key):
	multiply_by = 1
	x2.queue_free()

