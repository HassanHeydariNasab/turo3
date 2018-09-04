extends Control


func _ready():
	$BG.set_color(G.colors[G.Settings.get_value("color", "bgcolor", "gray")])
	$Enter_sound.set("playing", G.Settings.get_value("audio", "sounds", true))

func _on_Fontkodo_pressed():
	OS.shell_open("https://github.com/HassanHeydariNasab/turo3")

func _on_Atribuoj_pressed():
	OS.shell_open("https://github.com/HassanHeydariNasab/turo3/blob/master/ATTRIBUTION.md")

func _on_Bitcoin_pressed():
	OS.shell_open("bitcoin:1PUJ5sFWxvbx5Np2CjFmhHFnzPe2GPvinj")

func _on_Litecoin_pressed():
	OS.shell_open("litecoin:LgeGeVU9JAxyXpanPtsBRAX5QHxvUJo8id")

func _on_Ethereum_pressed():
	OS.shell_open("ethereum:0x8472eb39e5bddd14173bce4ed06e287876fb2f2c")

func _on_Reen_pressed():
	get_tree().change_scene("res://Menu.tscn")
