extends Node

# Signals 
signal completed

# Child nodes
onready var _timer = $Timer

# Program parameters
export (float) var delay_time

################################################################################
# PRIVATE METHODS
################################################################################

func _command_delay():
	_timer.start()

################################################################################
# PUBLIC METHODS
################################################################################

func end():
	var text = "'%s' program completed. " % name
	CommandConsole.update_command_log(text)
	
	emit_signal('completed')

#-------------------------------------------------------------------------------

func start(program_master):
	_timer.wait_time = delay_time
	
	var text = "Running '%s' program. " % name
	CommandConsole.update_command_log(text)
	
	_command_delay()

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_Timer_timeout():
	end()
