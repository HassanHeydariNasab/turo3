'''converting pixel to meter'''
extends Node2D

@onready var K = get_node("K")
@onready var Timer = get_node("Timer")

func _ready():
	set_physics_process(true)  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review

func _physics_process(delta):  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review
	if K.get_colliding_bodies().size() != 0:
		
		var v = 9.8 * (Timer.get_wait_time() -Timer.get_time_left())
		var d_y = pow(v, 2) / (2*9.8)
		
		print('1 pixel is ', d_y/1000, ' meters')
		set_physics_process(false)  #-- NOTE: Automatically converted by Godot 2 to 3 converter, please review

