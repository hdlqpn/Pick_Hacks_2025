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

var turn: int = 1
var p1_move: int = 4
var p2_move: int = 4


func _ready() -> void:
	var player_start_pos: Vector2i = Grid.world_to_grid(get_viewport_rect().size.floor() / 2)
	player = Entity.new(player_start_pos, player_definition)
	entities.add_child(player)
	player2 = Entity.new(Vector2i(8,8), player2_definition)
	entities.add_child(player2)
	setup_camera()
	
func get_map_data() -> MapData:
	return map.map_data

func _process(delta: float) -> void:
	#var turn: int = 0
	var alive: bool = true
	
	var action: MovementAction = event_handler.get_action(1)
	var action2: MovementAction = event_handler.get_action(2)
	#if action || action2:
		#action.perform(self, player)
		#action2.perform(self, player2)
		
	
	if turn == 1:
		if action.offset != Vector2i(0,0):
			action.perform(self, player)
			p1_move = p1_move - 1
			#print("Player 1")
	elif turn == 2:
		if action2.offset != Vector2i(0,0):
			action2.perform(self, player2)
			p2_move = p2_move - 1
			#print("Player 2")
	if p1_move == 0:
		print("I am trying to return it back to player 2")
		turn = 2
		p2_move = 4
		p1_move = -1
	if p2_move == 0:
		print("Hey I am trying to return it back to player 1")
		turn = 1
		p1_move = 4
		p2_move = -1

func setup_camera() -> void:
	var tile_size: int = 144
	var map_width: int = map.map_width
	var map_height: int = map.map_height
	
	camera.setup_camera(map_width, map_height, tile_size)
