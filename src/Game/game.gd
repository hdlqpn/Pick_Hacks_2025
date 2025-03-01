class_name Game
extends Node2D

const player_definition: EntityDefinition = preload("res://src/Entities/Actors/Actions/entity_definition_player.tres")
const player2_definition: EntityDefinition = preload("res://src/Entities/Actors/Actions/entity_definition_player2.tres")

@onready var player: Entity
@onready var player2: Entity
@onready var event_handler: EventHandler = $EventHandler
@onready var map: Map = $Map
@onready var camera: Camera = $Camera2D
@onready var entities: Node2D = $Entities

func _ready() -> void:
	var player_start_pos: Vector2i = Grid.world_to_grid(get_viewport_rect().size.floor() / 2)
	player = Entity.new(player_start_pos, player_definition)
	entities.add_child(player)
	player2 = Entity.new(Vector2i(8,8), player2_definition)
	entities.add_child(player2)
	setup_camera()
	
func get_map_data() -> MapData:
	return map.map_data

func _physics_process(delta: float) -> void:
	var turn: int = 1
	var turn2: int = 2
	
	var action: Action = event_handler.get_action(turn)
	var action2: Action = event_handler.get_action(turn2)
	if action || action2:
		action.perform(self, player)
		action2.perform(self, player2)

func setup_camera() -> void:
	var tile_size: int = 144
	var map_width: int = map.map_width
	var map_height: int = map.map_height
	
	camera.setup_camera(map_width, map_height, tile_size)
