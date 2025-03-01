class_name MapData
extends RefCounted

const tile_types = {
	"floor": preload("res://src/Map/tile_definition_floor.tres"),
	"wall": preload("res://src/Map/tile_definition_wall.tres"),
}

var width: int
var height: int
var tiles: Array[Tile]
var entities: Array[Entity]

@export var player1_definition: EntityDefinition
@export var player2_definition: EntityDefinition

func _init(map_width: int, map_height: int) -> void:
	width = map_width
	height = map_height
	entities = []
	_setup_tiles()
	
func _setup_entities() -> void:
	entities.append({"position": Vector2i(1,1), "definition": player1_definition})
	entities.append({"position": Vector2i(8,8), "definition": player2_definition})

func _setup_tiles() -> void:
	tiles = []
	for y in height:
		for x in width:
			var tile_position := Vector2i(x, y)
			var tile := Tile.new(tile_position, tile_types.floor)
			tiles.append(tile)
	for x in range (0, width):
		get_tile(Vector2i(x, 0)).set_tile_type(tile_types.wall)
		get_tile(Vector2i(x, height - 1)).set_tile_type(tile_types.wall)
	
	for y in range (0, height):
		get_tile(Vector2i(0, y)).set_tile_type(tile_types.wall)
		get_tile(Vector2i(width -1, y)).set_tile_type(tile_types.wall)

func get_tile(grid_position: Vector2i) -> Tile:
	var tile_index: int = grid_to_index(grid_position)
	if tile_index == -1:
		return null
	return tiles[tile_index]

func grid_to_index(grid_position: Vector2i) -> int:
	if not is_in_bounds(grid_position):
		return -1
	return grid_position.y * width + grid_position.x

func is_in_bounds(coordinate: Vector2i) -> bool:
	return (
		0 <= coordinate.x
		and coordinate.x < width
		and 0 <= coordinate.y
		and coordinate.y < height
	)
