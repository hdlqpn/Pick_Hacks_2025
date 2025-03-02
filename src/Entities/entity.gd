class_name Entity
extends Sprite2D

enum Direction {UP=0, DOWN=1, LEFT=2, RIGHT=3}

var texture_down: Texture2D
var texture_up: Texture2D
var texture_left: Texture2D
var texture_right: Texture2D
var hp_texture0: Texture2D
var hp_texture1: Texture2D 
var hp_texture2: Texture2D 
var hp_texture3: Texture2D 
var hp_texture4: Texture2D 
var hp_texture5: Texture2D 
var hp_texture6: Texture2D 
var hp_texture7: Texture2D 
var hp_texture8: Texture2D 
var hp_texture9: Texture2D 
var hp_texture10: Texture2D 
var direction: Direction

var grid_position: Vector2i:
	set(value):
		grid_position = value
		position = Grid.grid_to_world(grid_position)

func _init(start_position: Vector2i, entity_definition: EntityDefinition) -> void:
	centered = false
	grid_position = start_position
	texture_down = entity_definition.down_texture
	texture_up = entity_definition.up_texture
	texture_left = entity_definition.left_texture
	texture_right = entity_definition.right_texture
	hp_texture0 = entity_definition.hp_texture0
	hp_texture1 = entity_definition.hp_texture1
	hp_texture2 = entity_definition.hp_texture2
	hp_texture3 = entity_definition.hp_texture3
	hp_texture4 = entity_definition.hp_texture4
	hp_texture5 = entity_definition.hp_texture5
	hp_texture6 = entity_definition.hp_texture6
	hp_texture7 = entity_definition.hp_texture7
	hp_texture8 = entity_definition.hp_texture8
	hp_texture9 = entity_definition.hp_texture9
	hp_texture10 = entity_definition.hp_texture10
	texture = texture_down
	modulate = entity_definition.color
	direction = Direction.DOWN

func move(move_offset: Vector2i) -> void:
	grid_position += move_offset

func direction_from_enum(direction: Direction)-> Vector2i:
	if direction == Direction.UP:
		return Vector2i(0,1)
	elif direction == Direction.DOWN:
		return Vector2i(0,-1)
	elif direction == Direction.LEFT:
		return Vector2i(-1,0)
	elif direction == Direction.RIGHT:
		return Vector2i(1,0)
	else:
		return Vector2i(0,0)
