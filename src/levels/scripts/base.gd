extends TileMap

# Obstacle checking
var _rect = RectangleShape2D.new()
const RECT_OFFSET = Vector2(8, 8)

# Entities
const ENTITY_OFFSET = Vector2(8, 0)

################################################################################
# PRIVATE METHODS
################################################################################

func _check_for_obstacle(cell, map_entities):
	var has_obstacle = false
	var space = get_world_2d().direct_space_state
	var query = Physics2DShapeQueryParameters.new()
	_rect.extents = cell_size / 2
	query.set_shape(_rect)
	query.transform = Transform2D(0, map_to_world(cell) + RECT_OFFSET)
	
	var results = space.intersect_shape(query)
	
	if results:
		has_obstacle = true
	
	return has_obstacle

#-------------------------------------------------------------------------------

func _check_out_of_bounds(cell):
	var is_out_of_bounds = true
	
	if cell in get_used_cells():
		is_out_of_bounds = false
	
	return is_out_of_bounds

################################################################################
# PUBLIC METHODS
################################################################################

func validate_move(character, direction, map_entities):
	var current_cell = world_to_map(character.global_position)
	var target_cell = current_cell + direction
	var has_obstacle = _check_for_obstacle(target_cell, map_entities)
	var is_out_of_bounds = _check_out_of_bounds(target_cell)
	
	if has_obstacle or is_out_of_bounds:
		return character.global_position
	else:
		var new_position = map_to_world(target_cell)
		new_position.x += ENTITY_OFFSET.x
		new_position.y += ENTITY_OFFSET.y
		return new_position
