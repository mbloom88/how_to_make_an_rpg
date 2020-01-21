extends "res://entities/characters/scripts/character.gd"

################################################################################
# PRIVATE METHODS
################################################################################

func _initialize():
	_states_map = {
		'inactive': $States/Inactive,
		'idle': $States/Idle,
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
	_change_state('idle')

#-------------------------------------------------------------------------------

func deactivate():
	_change_state('inactive')
