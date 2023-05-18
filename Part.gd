extends RigidBody2D

@onready var Look = $Look

func _ready():
	if G.Main.color == "000000":
		Look.set_color("000000")
	set_process(true)

func _process(delta):
	if get_colliding_bodies().size() > 0:
		set_collision_layer_value(11,false)
		set_collision_layer_value(1,true)
		G.Main.height = abs(get_global_position().y-Look.get_scale().y/2)  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
		if G.Main.octave == 3:
			G.Main.C5_pizzicato.set("playing", G.Settings.get_value("audio", "sounds", true))
		elif G.Main.octave == 5:
			G.Main.C3_pizzicato.set("playing", G.Settings.get_value("audio", "sounds", true))
		set_process(false)
