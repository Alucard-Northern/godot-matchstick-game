# LeftHand.gd (Extends Hand.gd)
extends "res://scripts/Hand.gd"

func animate_matchbox():
	# Create a sequence tween
	var tween = get_tree().create_tween()
	# Configure the tween
	tween.set_trans(Tween.TRANS_LINEAR)
	# Add property tweens in sequence
	tween.tween_property(self, "position", Vector2(position.x + 50, position.y), 0.2)
	tween.tween_interval(0.5) # Add delay between animations
	tween.tween_property(self, "position", original_position, 0.2)
