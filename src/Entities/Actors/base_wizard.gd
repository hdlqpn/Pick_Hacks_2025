class_name BaseWizard
extends Entity

const MAX_HEALTH: int = 10
const MAX_MANA: int = 10
const MAX_MOVE: int = 3
const MAX_ACTIONS: int = 1

var current_health: int
var current_mana: int
var current_move: int
var current_actions: int
var is_alive: bool = true

@export var health_bar_scene: PackedScene
var health_bar: HealthBar

@export var mana_bar_scene: PackedScene
var mana_bar: ManaBar

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
	current_health = MAX_HEALTH
	current_mana = MAX_MANA
	current_move = MAX_MOVE
	current_actions = MAX_ACTIONS

func _ready() -> void:
	if health_bar_scene:
		health_bar = health_bar_scene.instantiate()
		add_child(health_bar)
		health_bar.set_health(current_health, MAX_HEALTH)
		print("Healthbar Added to scene: ", health_bar)
	
	if mana_bar_scene:
		mana_bar = mana_bar_scene.instantiate()
		add_child(mana_bar)
		mana_bar.set_mana(current_mana, MAX_MANA)

func add_health(value: int) -> void:
	var temp = current_health + value
	if temp > MAX_HEALTH:
		temp = MAX_HEALTH
	current_health = temp
	update_health_bar()

	
func sub_health(value: int) -> void:
	var temp = current_health - value
	if temp <= 0:
		temp = 0
		print("AAAAHHHH a fatal wound I have fallen")
		is_alive = false
	current_health = temp
	update_health_bar()


func add_mana(value: int) -> void:
	var temp = current_mana + value
	if temp > MAX_MANA:
		temp = MAX_MANA
	current_mana = temp
	update_mana_bar()


func sub_mana(value: int) -> void:
	var temp = current_mana - value
	if temp <= 0:
		temp = 0
	current_mana = temp
	update_mana_bar()

func add_move(value: int) -> void:
	var temp = current_move + value
	if temp > MAX_MOVE:
		temp = MAX_MOVE
	current_move = temp

func sub_move(value: int) -> void:
	var temp = current_move - value
	if temp <= 0:
		temp = 0
	current_move = temp

func add_actions(value: int) -> void:
	var temp = current_actions + value
	if temp > MAX_ACTIONS:
		temp = MAX_ACTIONS
	current_actions = temp

func sub_actions(value: int) -> void:
	var temp = current_actions - value
	if temp <= 0:
		temp = 0
	current_actions = temp

func update_health_bar() -> void:
	if health_bar:
		health_bar.set_health(current_health, MAX_HEALTH)

func update_mana_bar() -> void:
	if mana_bar:
		mana_bar.set_mana(current_mana, MAX_MANA)

func action_1(opponent: BaseWizard) -> void:
	#offset is the current player's position
	#If we add the direction to the current player's position and we end up hitting the opponents offset, then we have hit them
	var direction_vector = direction_from_enum(direction)
	
	print("I am in the process of performing the stab")
	print(grid_position-direction_vector)
	
	
	if direction_vector == Vector2i(0,0):
		print("AAAAHHHHHHHH This isn't getting the right value")
	var hit_position: Vector2i = Vector2i(grid_position.x + direction_vector.x, grid_position.y - direction_vector.y)
	if hit_position == opponent.grid_position:
		#stab
		print("I have stabbed my opponent")
		opponent.sub_health(1)
	pass

func action_2(opponent: BaseWizard) -> void:
	pass
	
func action_3(opponent: BaseWizard) -> void:
	pass

func action_4(opponent: BaseWizard) -> void:
	pass
