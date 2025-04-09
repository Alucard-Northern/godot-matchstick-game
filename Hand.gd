# Hand.gd (Base for both hands)
extends Sprite2D

var original_position

func _ready():
	original_position = position

func reset_position():
	position = original_position
	
