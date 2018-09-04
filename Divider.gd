extends Area2D


func _ready():
	if G.Main.color == "ffffff":
		$Look.set_color("ffffff")


func _on_Divider_body_entered( body ):
	shape_owner_clear_shapes(0)
	G.Main.Divider_sound.set("playing", G.Settings.get_value("audio", "sounds", true))
	var Parts_ = G.Main.Parts.get_children()
	for Part_ in Parts_:
		Part_.queue_free()
	G.Main.Ground.set_global_position(Vector2(300,get_global_position().y-880))  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
	if G.Settings.get_value("color", "bgcolor", "Gray") == "Multicolor":
		G.Main.BG_Change.interpolate_property(G.Main.BG, "color",
			G.Main.BG.get_color(),
			Color(G.colors[G.multicolors[G.Main.bgcolor]]), 0.3,
			Tween.TRANS_QUAD, Tween.EASE_IN)
		G.Main.BG_Change.start()
		G.Main.bgcolor = (G.Main.bgcolor+1) % G.multicolors.size()
	queue_free()

