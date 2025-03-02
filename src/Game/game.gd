class_name Game
extends Node2D

const player_definition: EntityDefinition = preload("res://src/Entities/Actors/Actions/entity_definition_player.tres")
const player2_definition: EntityDefinition = preload("res://src/Entities/Actors/Actions/entity_definition_player2.tres")

@onready var player: BaseWizard
@onready var player2: BaseWizard
@onready var event_handler: EventHandler = $EventHandler
@onready var map: Map = $Map
@onready var camera: Camera = $Camera2D
@onready var entities: Node2D = $Entities

@export var max_move: int = 4
@export var max_actions: int = 1

var turn: int = 1
var p1_move: int = max_move
var p2_move: int = max_move
var p1_act: int = max_actions
var p2_act: int = max_actions
var p1_color: Color
var p2_color: Color
var inactive: Color = Color.GRAY


func _ready() -> void:
	var player_start_pos: Vector2i = Grid.world_to_grid(get_viewport_rect().size.floor() / 2)
	player = BaseWizard.new(player_start_pos, player_definition)
	p1_color = player.modulate
	entities.add_child(player)
	player2 = BaseWizard.new(Vector2i(8,8), player2_definition)
	p2_color = player2.modulate
	player2.modulate = inactive
	entities.add_child(player2)
	setup_camera()
	
func get_map_data() -> MapData:
	return map.map_data

func _process(delta: float) -> void:
	#var turn: int = 0
	var alive: bool = true
	
	var action: WizardAction = event_handler.get_action(1)
	var action2: WizardAction = event_handler.get_action(2)
	#if action || action2:
		#action.perform(self, player)
		#action2.perform(self, player2)
		
	
	if turn == 1:
		if (action.offset.x != 0 || action.offset.y != 0) && p1_move > 0:
			action.perform(self, player)
			p1_move = p1_move - 1
		elif action.offset.z != 0 && p1_act > 0:
			action.perform(self, player)
		
			if action.offset.z == 1:
				print("We are trying to perform action 1")
				player.action_1(player2)
				
			p1_act = p1_act - 1
	elif turn == 2:
		if (action2.offset.x != 0 || action2.offset.y != 0) && p2_move > 0:
			action2.perform(self, player2)
			p2_move = p2_move - 1
		elif action2.offset.z != 0 && p2_act > 0:
			action2.perform(self, player2)
			p2_act = p2_act - 1
			print("Player 2 Act: ", p2_act)
	if p1_move == 0 && p1_act == 0:
		print("I am trying to return it back to player 2")
		player.modulate = inactive
		player2.modulate = p2_color
		turn = 2
		p2_move = max_move
		p2_act = max_actions
		p1_move = -1
		p1_act = -1
	if p2_move == 0 && p2_act == 0:
		print("Hey I am trying to return it back to player 1")
		player2.modulate = inactive
		player.modulate = p1_color
		turn = 1
		p1_move = max_move
		p1_act = max_actions
		p2_move = -1
		p2_act = -1

func setup_camera() -> void:
	var tile_size: int = 144
	var map_width: int = map.map_width
	var map_height: int = map.map_height
	
	camera.setup_camera(map_width, map_height, tile_size)
