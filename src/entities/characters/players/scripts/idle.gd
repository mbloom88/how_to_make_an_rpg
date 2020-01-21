extends "res://assets/scripts/state.gd"

################################################################################
# PRIVATE METHODS
################################################################################

func _update_idle_direction(host):
	match host._facing_direction:
		Vector2.DOWN:
			host._sprite_anim.play('idle_down')
		Vector2.UP:
			host._sprite_anim.play('idle_up')
		Vector2.LEFT:
			host._sprite_anim.play('idle_left')
		Vector2.RIGHT:
			host._sprite_anim.play('idle_right')

#-------------------------------------------------------------------------------

func _detect_input(host):
	var input_direction = Vector2.ZERO
	
	if Input.is_action_pressed('move_down'):
		input_direction = Vector2.DOWN
	elif Input.is_action_pressed('move_up'):
		input_direction = Vector2.UP
	elif Input.is_action_pressed('move_left'):
		input_direction = Vector2.LEFT
	elif Input.is_action_pressed('move_right'):
		input_direction = Vector2.RIGHT
	
	return input_direction

################################################################################
# PUBLIC METHODS
################################################################################

func enter(host):
	host.set_process(true)
	_update_idle_direction(host)

#-------------------------------------------------------------------------------

func handle_process(host, delta):
	var input_direction = _detect_input(host)
	
	if input_direction:
		return 'move'
