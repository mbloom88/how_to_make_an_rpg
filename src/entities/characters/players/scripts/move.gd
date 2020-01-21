extends "res://assets/scripts/state.gd"

const MOVE_SPEED = 0.15

################################################################################
# PRIVATE METHODS
################################################################################

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

#-------------------------------------------------------------------------------

func _update_move_animation(host, new_direction):
	host._facing_direction = new_direction
	
	match new_direction:
		Vector2.DOWN:
			host._sprite_anim.play('move_down')
		Vector2.UP:
			host._sprite_anim.play('move_up')
		Vector2.LEFT:
			host._sprite_anim.play('move_left')
		Vector2.RIGHT:
			host._sprite_anim.play('move_right')

################################################################################
# PUBLIC METHODS
################################################################################

func enter(host):
	host.set_process(true)

#-------------------------------------------------------------------------------

func handle_process(host, delta):
	var input_direction = _detect_input(host)
	
	if input_direction:
		host.emit_signal('move_requested', host, input_direction)
		host.set_process(false)
		_update_move_animation(host, input_direction)
	else:
		return 'idle'

#-------------------------------------------------------------------------------

func move(host, new_position):
	if new_position == host.global_position:
		yield(get_tree().create_timer(0.05), 'timeout')
		host.set_process(true)
		return
	
	host._move_tween.interpolate_property(
		host,
		'global_position',
		host.global_position,
		new_position,
		MOVE_SPEED,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN)
	
	host._move_tween.start()
	host.emit_signal('camera_move_requested', new_position, 100.0)

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_MoveTween_tween_completed(host, object, key):
	host.set_process(true)
