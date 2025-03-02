class_name DefWizard
extends BaseWizard

var shield: bool

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
	shield = false

func _ready() -> void:
	texture_down = preload("res://144_size_character_sprites/Def_Front_144.png")
	texture_up = preload("res://144_size_character_sprites/Def_Back_144.png")
	texture_left = preload("res://144_size_character_sprites/Def_Left_144.png")
	texture_right = preload("res://144_size_character_sprites/Def_Right_144.png")
	texture = texture_down
	
	if health_bar_scene:
		health_bar = health_bar_scene.instantiate()
		add_child(health_bar)
		health_bar.set_health(current_health, MAX_HEALTH)
		print("Healthbar Added to scene: ", health_bar)
	
	if mana_bar_scene:
		mana_bar = mana_bar_scene.instantiate()
		add_child(mana_bar)
		mana_bar.set_mana(current_mana, MAX_MANA)

func sub_health(value: int) -> void:
	if shield == true:
		self.add_mana(2)
		shield = false
		return
	
	var temp = current_health - value
	if temp <= 0:
		temp = 0
		print("AAAAHHHH a fatal wound I have fallen")
		is_alive = false
	current_health = temp
	update_health_bar()

func action_1(opponent: BaseWizard) -> void:
	shield = false
	super.action_1(opponent)
	#offset is the current player's position
	#If we add the direction to the current player's position and we end up hitting the opponents offset, then we have hit them
	

func action_2(opponent: BaseWizard) -> void:
	var direction_vector = direction_from_enum(direction)
	shield = false
	if self.current_mana < 1:
		self.sub_mana(100)
		return
	if direction_vector == Vector2i(0,0):
		print("Wrong values")
	var hit_position: Vector2i = Vector2i(grid_position.x + (2 * direction_vector.x), grid_position.y - (2 * direction_vector.y))
	
	if hit_position == opponent.grid_position:
		opponent.sub_health(3)
	
	self.sub_mana(1)
	pass
	
func action_3(opponent: BaseWizard) -> void:
	if self.current_mana < 3:
		self.sub_mana(100)
		return
	shield = true
	self.sub_mana(3)
	pass

func action_4(opponent: BaseWizard) -> void:
	shield = false
	if self.current_mana < 2:
		self.sub_mana(100)
		return
	self.sub_mana(2)
	var direction_vector = direction_from_enum(direction)
	if direction_vector == Vector2i(0,0):
		print("Wrong values")
	var hit_position_2: Vector2i = Vector2i(grid_position.x + (2 * direction_vector.x), grid_position.y - (2 * direction_vector.y))
	var hit_position: Vector2i = Vector2i(grid_position.x + direction_vector.x, grid_position.y - direction_vector.y)
	
	if hit_position == opponent.grid_position:
		opponent.sub_health(3)
		
		var temp = opponent.grid_position
		opponent.grid_position = self.grid_position
		self.grid_position = temp
	
	
	pass
