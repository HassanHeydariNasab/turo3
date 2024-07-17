extends Node2D

@onready var PrePart = $PrePart
@onready var MainCamera = $MainCamera
@onready var BG = $BG
@onready var Ground = $Ground
@onready var V_ScrollBar = $Canvas/V_ScrollBar
@onready var look_Ink = $Canvas/look_Ink
@onready var look_Height = $Canvas/look_Height
@onready var look_Record = $Canvas/look_Record
@onready var Parts = $Parts
@onready var Inks = $Inks
@onready var Rectangles = $Rectangles
@onready var Dividers = $Dividers
@onready var T500 = $T500
@onready var T30000 = $T30000
@onready var BG_music  = $BG_music
@onready var C3_spiccato = $C3_spiccato
@onready var C5_spiccato = $C5_spiccato
@onready var E3_spiccato = $E3_spiccato
@onready var E5_spiccato = $E5_spiccato
@onready var G3_spiccato = $G3_spiccato
@onready var G5_spiccato = $G5_spiccato
@onready var B3_spiccato = $B3_spiccato
@onready var B5_spiccato = $B5_spiccato
@onready var C3_pizzicato = $C3_pizzicato
@onready var C5_pizzicato = $C5_pizzicato
@onready var E3_tremolo = $E3_tremolo
@onready var G3_tremolo = $G3_tremolo
@onready var E3_timpani = $E3_timpani
@onready var C3_chimes = $C3_chimes
@onready var C4_chimes = $C4_chimes
@onready var Crash_14 = $Crash_14
@onready var Hit_6 = $Hit_6
@onready var Growth_sound  = $Growth_sound
@onready var Divider_sound  = $Divider_sound
@onready var Ink1_sound  = $Ink1_sound
@onready var Ink2_sound  = $Ink2_sound
@onready var Ink3_sound  = $Ink3_sound
@onready var Ink4_sound  = $Ink4_sound
@onready var Ink5_sound  = $Ink5_sound
@onready var D6_pizzicato = $D6_pizzicato
#@onready var FPS = $Canvas/FPS
@onready var Part = preload("res://Part.tscn")
@onready var Ink = preload("res://Ink.tscn")
@onready var Rectangle = preload("res://Rectangle.tscn")
@onready var Divider = preload("res://Divider.tscn")


var height = 0: set = set_height
func set_height(value):
	if value*0.1184 >= height:
		height = round(value*0.1184)
		V_ScrollBar.set_value(-value-300)
		look_Height.set_text(str(height)+"m")
		if height > G.Settings.get_value("Record", "record",0):
			$BG_music.set_volume_db(5)
			G.Settings.set_value("Record", "record", height)
			G.Settings.set_value("Record", "is_submitted", false)
			G.Settings.save(G.settings_file)
			look_Record.set_text(
				str(G.Settings.get_value("Record", "record",0))+"m"
			)
			var tween = create_tween()
			tween.tween_property(look_Record,
				"theme_override_colors/font_color", Color("D500F9"), 0.25,
			).from(Color("FFFFFF"))
			tween.tween_property(look_Record,
				"theme_override_colors/font_color", Color("ffffff"), 0.25,
			)
		else:
			BG_music.set_volume_db(0)

var ink : set = set_ink
func set_ink(value):
	var tween = create_tween()
	tween.tween_property(
		look_Ink, 'value', int(value), 0.1
	).set_ease(Tween.EASE_OUT)
	ink = int(value)

var octave = 3

var color = "000000"

var rectangle = false

var overlaps = [] # overlapped physic bodies

var consumed_ink = 0

# index for multicolor
var bgcolor = 0

func _ready():
	G.Main = self
	self.ink = 100
	self.height = 0
	look_Record.set_text(
		str(G.Settings.get_value("Record", "record","0"))+"m"
	)
	BG.set_color(G.colors[G.colors_order[0]])
	color = G.colors[G.Settings.get_value("color", "color", "Black")]
	var Infinity = $Infinity
	Infinity.set_global_position(Vector2(0,-101300))  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
	if G.Main.color == "ffffff":
		$Ground/Look.set_color("ffffff")
		$PrePart/Look.set_color("ffffff")
		Infinity.set("theme_override_colors/font_color", "ffffff")
	V_ScrollBar.set_min(-101000)
	for i in range(-101000, -500, 700):
		randomize()
		var Rectangle_ = Rectangle.instantiate()
		Rectangle_.set_global_position(  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
			Vector2(randf_range(100,500),
			i
		))
		Rectangles.add_child(Rectangle_)
	for i in range(-101000, 0, 250):
		randomize()
		var Ink_ = Ink.instantiate()
		var ink_ = int(randf_range(50,200))
		Ink_.ink = ink_/2.85
		Ink_.set_scale(Vector2(ink_/50.0, ink_/50.0))
		Ink_.set_global_position(  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
			Vector2(randf_range(300-ink_,300+ink_),
			i
		))
		Inks.add_child(Ink_)
	for i in range(-101000, -4000, 12000):
		randomize()
		var Divider_ = Divider.instantiate()
		Divider_.set_global_position(  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
			Vector2(300, i+randf_range(-2000,4000))
		)
		Dividers.add_child(Divider_)
	BG_music.set("playing", G.Settings.get_value("audio", "music", true))
	set_process_input(true)
	set_physics_process(true)  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review

func _input(event):
	if event is InputEventMouseButton:  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.position.y > 70 and event.position.x < 570:  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
				if event.is_pressed() and ink > 0:
					consumed_ink = 0
					PrePart.set_scale(Vector2(1,1))
					PrePart.set_global_position(get_global_mouse_position())  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
					PrePart.show()
					Growth_sound.stop()
					Growth_sound.set("playing", G.Settings.get_value("audio", "sounds", true))
				elif PrePart.is_visible():
					if overlaps.size() == 0:
						PrePart.hide()
						Growth_sound.stop()
						if rectangle:
							rectangle = false
						if octave == 3:
							if height < 2000:
								C3_spiccato.set("playing", G.Settings.get_value("audio", "sounds", true))
							elif height > 8000:
								B3_spiccato.set("playing", G.Settings.get_value("audio", "sounds", true))
							elif height > 4000:
								G3_spiccato.set("playing", G.Settings.get_value("audio", "sounds", true))
							elif height >= 2000:
								E3_spiccato.set("playing", G.Settings.get_value("audio", "sounds", true))
							octave = 5
						elif octave == 5:
							if height < 2000:
								C5_spiccato.set("playing", G.Settings.get_value("audio", "sounds", true))
							elif height > 8000:
								B5_spiccato.set("playing", G.Settings.get_value("audio", "sounds", true))
							elif height > 4000:
								G5_spiccato.set("playing", G.Settings.get_value("audio", "sounds", true))
							elif height >= 2000:
								E5_spiccato.set("playing", G.Settings.get_value("audio", "sounds", true))
							octave = 3
						var Part_ = Part.instantiate()
						Part_.set_global_position(PrePart.get_global_position())  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
						var Shape_ = RectangleShape2D.new()
						Shape_.size = Vector2(20,20)*PrePart.get_scale()
						Part_.create_shape_owner(Shape_)
						Part_.shape_owner_add_shape(0, Shape_)
						Part_.set_mass(PrePart.get_scale().x/100)
						Part_.set_sleeping(false)
						Parts.add_child(Part_)
						Part_.Look.set_scale(PrePart.get_scale())
					else:
						PrePart.hide()
						Growth_sound.stop()
						self.ink += consumed_ink/2

		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			V_ScrollBar.set_value(V_ScrollBar.get_value()-100)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			V_ScrollBar.set_value(V_ScrollBar.get_value()+100)
	elif event is InputEventMouseMotion:  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
		if event.position.y > 70 and event.position.x < 570:  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
			PrePart.set_global_position(get_global_mouse_position())  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review

func _physics_process(delta):  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
	if PrePart.is_visible() and self.ink > 0:
		var factor = PrePart.get_scale().x
		factor += 1/factor
#		PrePart.set_scale(PrePart.get_scale()+Vector2(0.1,0.1))
		if rectangle:
			PrePart.set_scale(Vector2(factor,factor*1.618))
		else:
			PrePart.set_scale(Vector2(factor,factor))
		self.ink -= 1
		consumed_ink += 1
	elif self.ink <= 0:
		Growth_sound.stop()

#func _process(delta):
#	FPS.set_text(str(int(1.0/delta)))

func _on_H_ScrollBar_value_changed( value ):
	$MainCamera.set_offset(Vector2(value,$MainCamera.get_offset().y))
	BG.set_global_position($MainCamera.get_offset()+Vector2(-300,-500))  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review

func _on_V_ScrollBar_value_changed( value ):
	$MainCamera.set_offset(Vector2($MainCamera.get_offset().x,value))
	BG.set_global_position($MainCamera.get_offset()+Vector2(-300,-500))  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review

func _on_Restart_pressed():
	get_tree().reload_current_scene()

var sum_speed_x = 0
var sum_speed_y = 0
var speed = 0
var average_speed_x = 0
var average_speed_y = 0
var parts = 1
var difference = 0
func _on_T500_timeout():
	sum_speed_x = 0
	sum_speed_y = 0
	parts = 1
	for Part_ in Parts.get_children():
		if Part_.get_collision_layer_value(1):
			speed = Part_.get_linear_velocity()
			sum_speed_x += abs(speed.x)
			sum_speed_y += abs(speed.y)
			parts += 1
	average_speed_x = sum_speed_x / parts
	average_speed_y = sum_speed_y / parts
	difference = average_speed_x - average_speed_y
	if difference > 2 and parts > 5:
		if not E3_timpani.is_playing():
			E3_timpani.set("playing", G.Settings.get_value("audio", "sounds", true))
		if average_speed_x > 6:
			E3_tremolo.set_volume_db(-15)
			G3_tremolo.set_volume_db(-3)
			if not G3_tremolo.is_playing():
				G3_tremolo.set("playing", G.Settings.get_value("audio", "sounds", true))
		elif average_speed_x > 2:
			E3_tremolo.set_volume_db(-3)
			G3_tremolo.set_volume_db(-15)
			if not E3_tremolo.is_playing():
				E3_tremolo.set("playing", G.Settings.get_value("audio", "sounds", true))
	elif parts >= 20:
		if difference < -50:
			C3_chimes.set("playing", G.Settings.get_value("audio", "sounds", true))
			T30000.start()
			T500.stop()
	elif parts < 20 and parts > 5:
		if difference < -25:
			C4_chimes.set("playing", G.Settings.get_value("audio", "sounds", true))
			T30000.start()
			T500.stop()

func _on_Back_pressed():
	get_tree().change_scene_to_file("res://Menu.tscn")

func _on_T30000_timeout():
	T500.start()

func _on_PrePart_body_entered( body ):
	overlaps.append(body)

func _on_PrePart_body_exited( body ):
	overlaps.erase(body)
