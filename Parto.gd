extends RigidBody2D

onready var Aspekto = get_node("Aspekto")

func _ready():
	if T.Radiko.koloro == "000000":
		get_node("Aspekto").set_color("000000")
	set_process(true)

func _process(delta):
	if get_colliding_bodies() != []:
		set_collision_layer_bit(10,false)
		set_collision_layer_bit(0,true)
		T.Radiko.alto = abs(get_global_position().y-Aspekto.get_scale().y/2)  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
		if T.Radiko.oktavo == 3:
			T.Radiko.C5_pizzicato.set("playing", T.Agordejo.get_value("Agordoj", "Sonoj", true))
		elif T.Radiko.oktavo == 5:
			T.Radiko.C3_pizzicato.set("playing", T.Agordejo.get_value("Agordoj", "Sonoj", true))
		set_process(false)
