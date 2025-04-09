# RightHand.gd (Extends Hand.gd)
extends "res://scripts/Hand.gd"

func animate_strike():
	# Create a sequence tween with acceleration
	var tween = get_tree().create_tween()
	# Configure the tween
	tween.set_trans(Tween.TRANS_EXPO)  # Use EXPO for acceleration effect
	tween.set_ease(Tween.EASE_IN)      # IN for acceleration
	
	# Move to the matchbox position with acceleration
	var target_pos = Vector2($"../LeftHand".position.x + 400, position.y + 300)
	tween.tween_property(self, "position", target_pos, 0.3)
	
	# Only play the full animation if this is the final successful attempt
	if $"../".success_count >= $"../".required_successes:
		# Keep hand at matchbox position if match is lit
		pass
	else:
		# Add a small delay and then return to original position
		tween.tween_interval(0.3)
		tween.tween_property(self, "position", original_position, 0.5)
