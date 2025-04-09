# Main.gd
extends Node2D

var success_count = 0
var required_successes = 5  # The number of attempts needed to light the match
var base_speed = 500
var speed_increment = 100
var current_speed
var game_over = false
var match_lit = false

func _ready():
	$UI/GameOverPanel.visible = false
	$UI/AttemptsLabel.text = "Attempts: 0/" + str(required_successes)
	reset_game()

func reset_game():
	success_count = 0
	current_speed = base_speed
	$UI/AttemptsLabel.text = "Attempts: 0/" + str(required_successes)
	$Arrow.speed = current_speed
	$RightHand.position = Vector2(320, 192)
	$LeftHand.position = Vector2(200, 400)
	game_over = false
	match_lit = false
	$UI/GameOverPanel.visible = false
	$MatchLight.visible = false

func _input(event):
	if event is InputEventKey and event.pressed:
		if game_over and event.keycode == KEY_SPACE:
			reset_game()
			return
			
		if not game_over and event.keycode == KEY_SPACE:
			check_timing()

func check_timing():
	var arrow_pos = $Arrow.position.x
	var green_start = $ColorBar/GreenZone.position.x
	var green_end = green_start + $ColorBar/GreenZone.size.x
	
	if arrow_pos >= green_start and arrow_pos <= green_end:
		# Success
		success_count += 1
		$UI/AttemptsLabel.text = "Attempts: " + str(success_count) + "/" + str(required_successes)
		
		# Play right hand animation only
		$RightHand.animate_strike()
		
		# Increase difficulty
		current_speed += speed_increment
		$Arrow.speed = current_speed
		
		# Check if we've reached the required number of attempts
		if success_count >= required_successes:
			# Match is lit!
			match_lit = true
			$MatchLight.visible = true
			$MatchLight/AnimationPlayer.play("flicker")
			$UI/GameOverPanel/ResultLabel.text = "You've successfully lit the match!"
			$UI/GameOverPanel.visible = true
			game_over = true
	else:
		# Failure
		$UI/GameOverPanel/ResultLabel.text = "You missed! Try again."
		$UI/GameOverPanel.visible = true
		game_over = true
