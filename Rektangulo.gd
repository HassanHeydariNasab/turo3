extends Area2D

onready var Kasxi = get_node("Kasxi")

func _ready():
	if T.Radiko.koloro == "ffffff":
		get_node("Aspekto").set_color("ffffff")
	randomize()
	if int(rand_range(0,2)) == 0:
		rotate(deg2rad(15))
	else:
		rotate(deg2rad(-15))

func _on_Rektangulo_body_enter( korpo ):
	shape_owner_clear_shapes(0)
	T.Radiko.Crash_14.set("playing", T.Agordejo.get_value("Agordoj", "Sonoj", true))
	var Aspekto = get_node("Aspekto")
	Kasxi.interpolate_property(Aspekto, "color",
		Color("ffffff"), Color("00D500F9"), 0.25,
		Tween.TRANS_SINE, Tween.EASE_OUT
	)
	Kasxi.start()

func _on_Kasxi_tween_complete( objekto, klavo ):
	T.Radiko.rektangulo = true
	queue_free()

func _on_Rektangulo_area_enter( areo ):
	if areo.get_collision_layer_bit(1) == true:
		queue_free()

