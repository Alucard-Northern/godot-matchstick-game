# Arrow.gd
extends Sprite2D

var speed = 500
var direction = 1
var min_x
var max_x

func _ready():
	min_x = $"../ColorBar".position.x
	max_x = min_x + $"../ColorBar".size.x

func _process(delta):
	if $"../".game_over:
		return
		
	position.x += speed * direction * delta
	
	if position.x >= max_x or position.x <= min_x:
		direction *= -1
