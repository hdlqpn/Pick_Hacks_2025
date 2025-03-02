class_name BaseWizard
extends Entity

const MAX_HEALTH: int = 10
const MAX_MANA: int = 10

var current_health: int
var current_mana: int
var is_alive: bool = true

func _init(start_position: Vector2i, entity_definition: EntityDefinition) -> void:
	centered = false
	grid_position = start_position
	texture_down = entity_definition.down_texture
	texture_up = entity_definition.up_texture
	texture_left = entity_definition.left_texture
	texture_right = entity_definition.right_texture
	texture = texture_down
	modulate = entity_definition.color
	direction = Direction.DOWN



func add_health(value: int) -> void:
	var temp = current_health + value
	if temp > MAX_HEALTH:
		temp = MAX_HEALTH
	current_health = temp
	
func sub_health(value: int) -> void:
	var temp = current_health - value
	if temp <= 0:
		temp = 0
		print("AAAAHHHH a fatal wound I have fallen")
		is_alive = false
	current_health = temp

func add_mana(value: int) -> void:
	var temp = current_mana + value
	if temp > MAX_MANA:
		temp = MAX_MANA
	current_mana = temp

func sub_mana(value: int) -> void:
	var temp = current_mana - value
	if temp <= 0:
		temp = 0
	current_mana = temp

func action_1(opponent: BaseWizard) -> void:
	#offset is the current player's position
	#If we add the direction to the current player's position and we end up hitting the opponents offset, then we have hit them
	var direction_vector = direction_from_enum(direction)
	
	print("I am in the process of performing the stab")
	print(grid_position-direction_vector)
	
	
	if direction_vector == Vector2i(0,0):
		print("AAAAHHHHHHHH This isn't getting the right value")
	
	if grid_position-direction_vector == opponent.grid_position:
		#stab
		print("I have stabbed my opponent")
		opponent.sub_health(5)
	pass

func action_2(opponent: BaseWizard) -> void:
	pass
	
func action_3(opponent: BaseWizard) -> void:
	pass

func action_4(opponent: BaseWizard) -> void:
	pass
