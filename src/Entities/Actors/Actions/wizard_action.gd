class_name WizardAction
extends Action

var offset: Vector3i

func _init(dx: int, dy: int, dz: int) -> void:
	offset = Vector3i(dx, dy, dz)

func perform(game: Game, entity: Entity, enemy_pos: Vector2i = Vector2i(-1, -1)) -> void:
	var two_offset: Vector2i = Vector2i(offset.x, offset.y)
	var destination: Vector2i = entity.grid_position + two_offset
	
	var map_data: MapData = game.get_map_data()
	var destination_tile: Tile = map_data.get_tile(destination)
	
	# Detecting Direction
	if two_offset.y == -1:
		entity.texture = entity.texture_up
		entity.direction = entity.Direction.UP
	elif two_offset.y == 1:
		entity.texture = entity.texture_down
		entity.direction = entity.Direction.DOWN
	elif two_offset.x == 1:
		entity.texture = entity.texture_right
		entity.direction = entity.Direction.RIGHT
	elif two_offset.x == -1:
		entity.texture = entity.texture_left
		entity.direction = entity.Direction.LEFT
	
	print("Dest: ", destination)
	print("Enemy: ", enemy_pos)
	
	if destination == enemy_pos:
		return
	
	if not destination_tile or not destination_tile.is_walkable():
		return
	entity.move(two_offset)
