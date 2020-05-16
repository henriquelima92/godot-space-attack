extends KinematicBody2D

const SPEED = 500

onready var sprite = $Sprite

var screen_size 
var playerSize

func _ready():
	screen_size = get_viewport_rect().size.x
	playerSize = sprite.texture.get_width() * scale.x

func _process(delta):
	if Input.is_action_pressed("left"):
		position.x -= SPEED * delta
	elif Input.is_action_pressed("right"):
		position.x += SPEED * delta
		
	position.x = clamp(position.x, 0 + (playerSize/2), screen_size-(playerSize/2))
