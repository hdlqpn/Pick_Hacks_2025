class_name Game
extends Node2D

const GAME_OVER: PackedScene = preload("res://Start_Screen.tscn")

const player_definition: EntityDefinition = preload("res://src/Entities/Actors/Actions/entity_definition_player.tres")
const player2_definition: EntityDefinition = preload("res://src/Entities/Actors/Actions/entity_definition_player2.tres")

var health_bar_scene: PackedScene = preload("res://src/Utils/healthbar.tscn")
var mana_bar_scene: PackedScene = preload("res://src/Utils/manabar.tscn")

@onready var player: BaseWizard
@onready var player2: BaseWizard
@onready var event_handler: EventHandler = $EventHandler
@onready var map: Map = $Map
@onready var camera: Camera = $Camera2D
@onready var entities: Node2D = $Entities

var turn: int = 1
var p1_color: Color
var p2_color: Color
var inactive: Color = Color.GRAY

enum Wizards{AGGRO = 1, DEF = 2, STAT = 4, SUS = 3}

var player1_wizard: Wizards
var player2_wizard: Wizards

func _ready() -> void:
	var player_start_pos: Vector2i = Grid.world_to_grid(get_viewport_rect().size.floor() / 2)
	if player1_wizard == Wizards.AGGRO:
		player = AggroWizard.new(player_start_pos, player_definition)
	elif player1_wizard == Wizards.DEF:
		player = DefWizard.new(player_start_pos, player_definition)
	elif player1_wizard == Wizards.STAT:
		player = StatWizard.new(player_start_pos, player_definition)
	else:
		player = SusWizard.new(player_start_pos, player_definition)
		
	
		
	p1_color = player.modulate
	player.health_bar_scene = health_bar_scene
	player.mana_bar_scene = mana_bar_scene
	entities.add_child(player)
	
	if player2_wizard == Wizards.AGGRO:
		player2 = AggroWizard.new(Vector2i(7,7), player2_definition)
	elif player2_wizard == Wizards.DEF:
		player2 = DefWizard.new(Vector2i(7,7), player2_definition)
	elif player2_wizard == Wizards.STAT:
		player2 = StatWizard.new(Vector2i(7,7), player2_definition)
	else:
		player2 = SusWizard.new(Vector2i(7,7), player2_definition)
	p2_color = player2.modulate
	player2.modulate = inactive
	player2.health_bar_scene = health_bar_scene
	player2.mana_bar_scene = mana_bar_scene
	entities.add_child(player2)
	setup_camera()
	
func get_map_data() -> MapData:
	return map.map_data

func _process(delta: float) -> void:
	var action: WizardAction = event_handler.get_action(1)
	var action2: WizardAction = event_handler.get_action(2)
	
	if player.is_alive == false:
		print("Player 2 Wins!")
		get_tree().change_scene_to_packed(GAME_OVER)
	elif player2.is_alive == false:
		print("Player 1 Wins!")
		get_tree().change_scene_to_packed(GAME_OVER)
	
	if turn == 1:
		if (action.offset.x != 0 || action.offset.y != 0) && player.current_move > 0:
			action.perform(self, player, player2.grid_position)
			player.sub_move(1)
		elif action.offset.z != 0 && player.current_actions > 0:
			action.perform(self, player)
		
			if action.offset.z == 1:
				print("We are trying to perform action 1")
				player.action_1(player2)
			elif action.offset.z == 2:
				player.action_2(player2)
			elif action.offset.z == 3:
				print("CMOVE Before: ", player.current_move)
				player.action_3(player2)
				print("CMOVE After: ", player.current_move)
			elif action.offset.z == 4:
				player.action_4(player2)
			player.sub_actions(1)
	elif turn == 2:
		if (action2.offset.x != 0 || action2.offset.y != 0) && player2.current_move > 0:
			action2.perform(self, player2, player.grid_position)
			player2.sub_move(1)
		elif action2.offset.z != 0 && player2.current_actions > 0:
			action2.perform(self, player2)
			if action2.offset.z == 1:
				player2.action_1(player)
			elif action2.offset.z == 2:
				player2.action_2(player)
			elif action2.offset.z == 3:
				player2.action_3(player)
			elif action2.offset.z == 4:
				player2.action_4(player)
			player2.sub_actions(1)
	if player.current_move == 0 && player.current_actions == 0:
		print("I am trying to return it back to player 2")
		player.modulate = inactive
		player2.modulate = p2_color
		turn = 2
		player2.current_move = player2.MAX_MOVE
		player2.current_actions = player2.MAX_ACTIONS
		player.current_move = -1
		player.current_actions = -1
		player.current_move = -1
	if  player2.current_move == 0 && player2.current_actions == 0:
		print("Hey I am trying to return it back to player 1")
		player2.modulate = inactive
		player.modulate = p1_color
		turn = 1
		player.current_move = player.MAX_MOVE
		player.current_actions = player.MAX_ACTIONS
		player2.current_move = -1
		player2.current_actions = -1

func setup_camera() -> void:
	var tile_size: int = 144
	var map_width: int = map.map_width
	var map_height: int = map.map_height
	
	camera.setup_camera(map_width, map_height, tile_size)
