class_name Map
extends Node2D

@export var map_width: int = 10;
@export var map_height: int = 10;
@onready var tiles: Node2D = $Tiles
#@onready var entities: Node2D = $Entities 

var map_data: MapData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map_data = MapData.new(map_width, map_height)
	_place_tiles()
#	_place_entities()
#	var player = 

#func _place_entities() -> void:
#	for entity in map_data.entities:
#		entities.add_child(entity)

func _place_tiles() -> void:
	for tile in map_data.tiles:
		tiles.add_child(tile)
