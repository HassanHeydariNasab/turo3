extends Area2D

@onready var tween: Tween


func _ready():
	tween = create_tween()
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
	# from Color("ffffff")
	tween.tween_property($Look, "color",
		Color("00D500F9"), 0.25
	)

func _on_Hide_tween_completed( object, key ):
	G.Main.rectangle = true
	queue_free()

func _on_Rectangle_area_entered( area ):
	# Remove overlapped elements
	if area.get_collision_layer_value(1) == true:
		queue_free()
