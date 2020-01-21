extends Camera2D

# Signals
signal moved_to_location

# Child nodes
onready var _move_tween = $MoveTween

# Character
var _current_character = null

################################################################################
# PUBLIC METHODS
################################################################################

func move_to_location(location, pan_speed):
	var distance = global_position.distance_to(location)
	var time = distance / pan_speed
	
	_move_tween.interpolate_property(
		self,
		'position',
		global_position,
		location,
		time,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN)
	
	_move_tween.start()

#-------------------------------------------------------------------------------

func track_character(character, pan_speed):
	if _current_character:
		untrack_character()
	
	_current_character = character
	_current_character.connect(
		'camera_move_requested', self, '_on_Character_camera_move_requested')

	move_to_location(character.global_position, pan_speed)

#-------------------------------------------------------------------------------

func untrack_character():
	if _current_character:
		_current_character.disconnect('camera_move_requested', self, 
			'_on_Character_camera_move_requested')
		_current_character = null

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_Character_camera_move_requested(location, pan_speed):
	move_to_location(location, pan_speed)

#-------------------------------------------------------------------------------

func _on_MoveTween_tween_completed(object, key):
	emit_signal('moved_to_location')
