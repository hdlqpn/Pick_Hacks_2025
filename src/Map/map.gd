class_name Map
extends Node2D

@export var map_width: int = 10;
@export var map_height: int = 10;

var map_data: MapData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map_data = MapData.new(map_width, map_height)
	_place_tiles()

func _place_tiles() -> void:
	for tile in map_data.tiles:
		add_child(tile)
