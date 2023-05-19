extends Area2D

var tween: Tween

func _ready():
	if G.Main.color == "ffffff":
		get_node("Look").set_color("ffffff")
	randomize()
	if int(randf_range(0,2)) == 0:
		rotate(deg_to_rad(15))
	else:
		rotate(deg_to_rad(-15))

func _on_Rectangle_body_entered( body ):
	shape_owner_clear_shapes(0)
	G.Main.Hit_6.set("playing", G.Settings.get_value("audio", "sound", true))
	tween = create_tween()
	tween.tween_property($Look, "color",
		Color("D500F9", 0), 0.25
	).from(Color("ffffff", 1))
	tween.tween_callback(_on_Hide_tween_completed)

func _on_Hide_tween_completed():
	G.Main.rectangle = true
	queue_free()

func _on_Rectangle_area_entered( area ):
	# Remove overlapped elements
	if area.get_collision_layer_value(1) == true:
		queue_free()
		#pass
