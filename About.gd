extends Control


func _on_Code_pressed():
	OS.shell_open("https://github.com/HassanHeydariNasab/turo3")

func _on_Attributions_pressed():
	OS.shell_open("https://github.com/HassanHeydariNasab/turo3/blob/master/ATTRIBUTIONS.md")

func _on_Liberapay_pressed():
	OS.shell_open("https://liberapay.com/hsn6")

func _on_Bitcoin_pressed():
	OS.shell_open("bitcoin:1PUJ5sFWxvbx5Np2CjFmhHFnzPe2GPvinj")

func _on_Litecoin_pressed():
	OS.shell_open("litecoin:LgeGeVU9JAxyXpanPtsBRAX5QHxvUJo8id")

func _on_Ethereum_pressed():
	OS.shell_open("ethereum:0x8472eb39e5bddd14173bce4ed06e287876fb2f2c")

func _on_Back_pressed():
	get_tree().change_scene_to_file("res://Menu.tscn")
