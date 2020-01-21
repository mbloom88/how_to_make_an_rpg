extends Node

# Signals
signal completed

# Program parameters
export (NodePath) var camera_node_path
export (float) var camera_pan_speed
export (NodePath) var character_node_path
var _camera = null
var _character = null

################################################################################
# PRIVATE METHODS
################################################################################

func _command_camera_to_track_character():
	_camera.track_character(_character, camera_pan_speed)

################################################################################
# PUBLIC METHODS
################################################################################

func end():
	_camera.disconnect('moved_to_location', self, 
		'_on_Camera_moved_to_location')
	
	var text = "'%s' program completed. " % name
	CommandConsole.update_command_log(text)
	
	emit_signal('completed')

#-------------------------------------------------------------------------------

func start(program_master):
	_camera = get_node(camera_node_path)
	_camera.connect('moved_to_location', self, '_on_Camera_moved_to_location')
	_character = get_node(character_node_path)
	
	var text = "Running '%s' program. " % name
	CommandConsole.update_command_log(text)
	
	_command_camera_to_track_character()

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_Camera_moved_to_location():
	end()