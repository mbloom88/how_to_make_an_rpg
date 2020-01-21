extends StaticBody2D

# Child nodes
onready var _collision = $CollisionShape2D

# Collision
export (bool) var _can_collide = true

################################################################################
# BUILT-IN VIRTUAL METHODS
################################################################################

func _ready():
	_initialize()

################################################################################
# PRIVATE METHODS
################################################################################

func _initialize():
	if not _can_collide:
		_collision.disabled = true
