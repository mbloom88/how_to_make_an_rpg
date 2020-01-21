extends Node2D

# Child nodes
onready var _base = $Base
onready var _char_sort = $YSort/Characters
onready var _cutscenes = $Cutscenes

################################################################################
# BUILT-IN VIRTUAL METHODS
################################################################################

func _ready():
	_initialize()

################################################################################
# PRIVATE METHODS
################################################################################

func _initialize():
	for character in _char_sort.get_children():
		character.connect('move_requested', self, 
			'_on_Character_move_requested')
	
	if _cutscenes.get_children():
		var first_cutscene = _cutscenes.get_child(0)
		first_cutscene.initialize()

################################################################################
# SIGNAL HANDLING
################################################################################

func _on_Character_move_requested(character, direction):
	var all_entities = _char_sort.get_children()
	var new_position = _base.validate_move(character, direction, all_entities)
	character.move(new_position)
