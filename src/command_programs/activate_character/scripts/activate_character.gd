extends Node

# Signals
signal completed

# Program parameters
export (NodePath) var character_node_path
var _character = null

################################################################################
# PRIVATE METHODS
################################################################################

func _activate_character():
	_character.activate()

################################################################################
# PUBLIC METHODS
################################################################################

func end():
	_character.disconnect('state_changed', self, '_on_Character_state_changed')
	
	var text = "'%s' program completed. " % name
	CommandConsole.update_command_log(text)
	
	emit_signal('completed')

#-------------------------------------------------------------------------------

func start(program_master):
	_character = get_node(character_node_path)
	_character.connect('state_changed', self, '_on_Character_state_changed')
	
	var text = "Running '%s' program. " % name
	CommandConsole.update_command_log(text)
	
	_activate_character()

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_Character_state_changed(character, new_state):
	assert new_state == 'idle'
	end()