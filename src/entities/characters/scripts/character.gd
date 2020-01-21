extends KinematicBody2D

# Signals 
signal camera_move_requested(character, pan_speed)
signal move_requested(character, direction)
signal state_changed(character, new_state)

# Child nodes
onready var _move_tween = $MoveTween
onready var _sprite_anim = $Sprite/AnimationPlayer
onready var _state_label = $StateLabel

# Character
export (String) var reference
export (bool) var is_starting_inactive = false
var _facing_direction = Vector2.DOWN

# State machine
var _states_map = {}
var _current_state = null
var _states_stack = []

################################################################################
# BUILT-IN VIRTUAL METHODS
################################################################################

func _process(delta):
	var new_state = _current_state.handle_process(self, delta)
	
	if new_state:
		_change_state(new_state)

#-------------------------------------------------------------------------------

func _ready():
	_initialize()

################################################################################
# PRIVATE METHODS
################################################################################

func _change_state(new_state):
	if not new_state in _states_map.keys():
		return
	
	if not _current_state:
		_current_state = _states_map[new_state]
		_states_stack.push_front(_current_state)
		_current_state.enter(self)
	else:
		_current_state.exit(self)
		if new_state == 'previous':
			_states_stack.pop_front()
			_current_state = _states_stack[0]
		else:
			_current_state = _states_map[new_state]
			_states_stack.pop_front()
			_states_stack.push_front(_current_state)
			_current_state.enter(self)
	
	emit_signal('state_changed', self, new_state)
	_state_label.update_text(new_state)

#-------------------------------------------------------------------------------

func _initialize():
	"""
	This method should be overwritten in inherited scripts. The body should
	consist of the following:
		
		- updated '_states_map'
		- '_change_state(new_state)' call to the desired initialization state.
	"""
	_states_map = {}
	_change_state('idle')

################################################################################
# PUBLIC METHODS
################################################################################

func activate():
	pass

#-------------------------------------------------------------------------------

func activate_debug_mode():
	_state_label.show()

#-------------------------------------------------------------------------------

func deactivate():
	pass

#-------------------------------------------------------------------------------

func deactivate_debug_mode():
	_state_label.hide()

#-------------------------------------------------------------------------------

func move(new_position):
	if _current_state.has_method('move'):
		_current_state.move(self, new_position)

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_MoveTween_tween_completed(object, key):
	if _current_state.has_method('_on_MoveTween_tween_completed'):
		_current_state._on_MoveTween_tween_completed(self, object, key)
