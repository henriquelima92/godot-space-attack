extends Node2D

export (PackedScene) var formation

var center
var offset = 100

func _ready():
	center = get_viewport().get_visible_rect().size.x / 2	
	_spawn_formation()

func _spawn_formation():
	randomize()
	var position_x = rand_range(center - offset, center + offset)
	var position_y = -250
	
	var new_formation = formation.instance()
	new_formation.position = Vector2(position_x, position_y)
	add_child(new_formation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
