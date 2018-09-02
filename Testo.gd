extends Node2D

onready var K = get_node("K")
onready var Tempilo = get_node("Tempilo")

func _ready():
	set_physics_process(true)  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review

func _physics_process(delta):  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
	if K.get_colliding_bodies().size() != 0:
		print(10-Tempilo.get_time_left())
		set_physics_process(false)  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review

