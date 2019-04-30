extends Area2D

onready var Hide = $Hide


func _ready():
	if G.Main.color == "ffffff":
		get_node("Look").set_color("ffffff")
	randomize()
	if int(rand_range(0,2)) == 0:
		rotate(deg2rad(15))
	else:
		rotate(deg2rad(-15))

func _on_Rectangle_body_entered( body ):
	shape_owner_clear_shapes(0)
	G.Main.Hit_6.set("playing", G.Settings.get_value("audio", "sound", true))
	Hide.interpolate_property($Look, "color",
		Color("ffffff"), Color("00D500F9"), 0.25,
		Tween.TRANS_SINE, Tween.EASE_OUT
	)
	Hide.start()

func _on_Hide_tween_completed( object, key ):
	G.Main.rectangle = true
	queue_free()

func _on_Rectangle_area_entered( area ):
	# Remove overlapped elements
	if area.get_collision_layer_bit(1) == true:
		queue_free()
