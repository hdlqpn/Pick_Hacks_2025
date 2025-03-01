class_name Map
extends Node2D

# Grid and tile size
const GRID_WIDTH: int = 10;
const GRID_HEIGHT: int = 10;
const TILE_SIZE: int = 144;

var tile_data := {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			var tile_pos = Vector2i(x, y)
			tile_data[tile_pos] = {"type": "empty", "walkable": true}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_tile_data(tile_pos: Vector2i, data: Dictionary):
	if tile_pos in tile_data:
		tile_data[tile_pos] = data
	else:
		print("Tile position out of bounds.") 

func get_tile_data(tile_pos: Vector2i) -> Dictionary:
	return tile_data.get(tile_pos, {"type": "none", "walkable":false})

func world_to_grid(world_pos: Vector2) -> Vector2i:
	return Vector2i(world_pos.x / TILE_SIZE, world_pos.y / TILE_SIZE)
	
func grid_to_world(grid_pos: Vector2i) -> Vector2:
	return Vector2(grid_pos.x * TILE_SIZE, grid_pos.y * TILE_SIZE)
