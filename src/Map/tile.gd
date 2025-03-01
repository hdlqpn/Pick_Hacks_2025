class_name Tile
extends Sprite2D

var _definition: TileDefinition

func _init(grid_position: Vector2i, tile_definition: TileDefinition) -> void:
	centered = false
	position = Grid.grid_to_world(grid_position)
	set_tile_type(tile_definition)

func set_tile_type(tile_definiton: TileDefinition) -> void:
	_definition = tile_definiton
	texture = _definition.texture
	modulate = _definition.color

func is_walkable() -> bool:
	return _definition.is_walkable
