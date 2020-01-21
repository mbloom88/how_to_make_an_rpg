extends Node

# Signals
signal all_programs_completed

# Programs
var _program_queue = []
var _current_program = null

################################################################################
# PRIVATE METHODS
################################################################################

func _run_next_program():
	if _current_program:
		_current_program.disconnect('completed', self, '_on_Program_completed')
		_current_program = null
	
	if _program_queue.empty():
		var text = "Program queue '%s' completed. " % name
		CommandConsole.update_command_log(text)
		emit_signal('all_programs_completed')
		return
	
	_current_program = _program_queue.pop_front()
	_current_program.connect('completed', self, '_on_Program_completed')
	_current_program.start(self)

################################################################################
# PUBLIC METHODS
################################################################################

func initialize():
	for program in get_children():
		_program_queue.append(program)
	
	var text = "Running new program queue '%s'. " % name
	CommandConsole.update_command_log(text)
	
	_run_next_program()

################################################################################
# SIGNLA HANDLING
################################################################################

func _on_Program_completed():
	_run_next_program()
