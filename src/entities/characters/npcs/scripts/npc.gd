extends "res://entities/characters/scripts/character.gd"

# NPC behavior
export (String, 'idle', 'wander') var world_behavior = 'idle'

################################################################################
# PRIVATE METHODS
################################################################################

func _initialize():
	_states_map = {
		'inactive': $States/Inactive,
		'idle': $States/Idle,
		'wander': $States/Wander,
		'move': $States/Move,
	}
	
	if is_starting_inactive:
		deactivate()
	else:
		activate()

################################################################################
# PUBLIC METHODS
################################################################################

func activate():
	match world_behavior:
		'idle':
			_change_state('idle')
		'wander':
			_change_state('wander')
			

#-------------------------------------------------------------------------------

func deactivate():
	_change_state('inactive')
