extends Area2D

onready var Kasxi = get_node("Kasxi")

var materialo = 100

func _ready():
	if T.Radiko.koloro == "ffffff":
		get_node("Aspekto").set_color("ffffff")

func _on_Materialo_body_enter( korpo ):
	shape_owner_clear_shapes(0)
	if materialo > 60:
		T.Radiko.Materialo5_sono.set("playing", T.Agordejo.get_value("Agordoj", "Sonoj", true))
	elif materialo > 50:
		T.Radiko.Materialo4_sono.set("playing", T.Agordejo.get_value("Agordoj", "Sonoj", true))
	elif materialo > 40:
		T.Radiko.Materialo3_sono.set("playing", T.Agordejo.get_value("Agordoj", "Sonoj", true))
	elif materialo > 30:
		T.Radiko.Materialo2_sono.set("playing", T.Agordejo.get_value("Agordoj", "Sonoj", true))
	elif materialo <= 30:
		T.Radiko.Materialo1_sono.set("playing", T.Agordejo.get_value("Agordoj", "Sonoj", true))
	var Aspekto = get_node("Aspekto")
	Kasxi.interpolate_property(Aspekto, "color",
		Color("ffffff"), Color("00D500F9"), 0.25,
		Tween.TRANS_SINE, Tween.EASE_OUT
	)
	Kasxi.start()

func _on_Kasxi_tween_complete( objekto, klavo ):
	T.Radiko.materialo += self.materialo
	queue_free()

func _on_Materialo_area_enter( areo ):
	if T.get_layer_bit(areo, 1) == true:
		queue_free()

