extends KinematicBody2D

const SPEED = 500

export(PackedScene) var projectile

onready var sprite = $Sprite
onready var timer = $Timer

var screen_size 
var playerSize
var can_shoot = true

func _ready():
	screen_size = get_viewport_rect().size.x
	playerSize = sprite.texture.get_width() * scale.x

func _process(delta):
	if Input.is_action_pressed("left"):
		position.x -= SPEED * delta
	elif Input.is_action_pressed("right"):
		position.x += SPEED * delta
		
	if can_shoot == true and Input.is_action_pressed("shoot"):
		can_shoot = false		
		var new_projectile = projectile.instance()
		new_projectile.position = position
		get_parent().add_child(new_projectile)
		timer.start()
		
	position.x = clamp(position.x, 0 + (playerSize/2), screen_size-(playerSize/2))


func _on_Timer_timeout():
	can_shoot = true
