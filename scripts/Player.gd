extends KinematicBody2D

const SPEED = 500

export(PackedScene) var projectile
export var health = 100

onready var sprite = $Sprite
onready var timer = $Timer
onready var deathTimer = $DeathTimer
onready var audio = $Audio

var screen_size 
var playerSize
var can_shoot = true
var dead = false

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
		audio.play()
		
	position.x = clamp(position.x, 0 + (playerSize/2), screen_size-(playerSize/2))


func _on_Timer_timeout():
	can_shoot = true

func add_damage(damage):
	if dead == true:
		return
		
	health -= damage
	if health <= 0:
		dead = true
		health = 0
		deathTimer.start()
		set_process(false)


func _on_DeathTimer_timeout():
	get_tree().reload_current_scene()
