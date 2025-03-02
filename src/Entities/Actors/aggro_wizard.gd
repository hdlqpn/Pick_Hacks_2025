class_name AggroWizard
extends BaseWizard

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
	texture_down = preload("res://144_size_character_sprites/Aggro_Front_144.png")
	texture_up = preload("res://144_size_character_sprites/Aggro_Back_144.png")
	texture_left = preload("res://144_size_character_sprites/Aggro_Left_144.png")
	texture_right = preload("res://144_size_character_sprites/Aggro_Right_144.png")
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

func add_move(value: int) -> void:
	var temp = current_move + value
	current_move = temp

func action_2(opponent: BaseWizard) -> void:
	var direction_vector = direction_from_enum(direction)
	if self.current_mana < 2:
		self.sub_mana(100)
		return
	if direction_vector == Vector2i(0,0):
		print("Wrong values")
	var hit_position_1: Vector2i = Vector2i(grid_position.x + direction_vector.x, grid_position.y - direction_vector.y)
	var hit_position_2: Vector2i = Vector2i(grid_position.x + (2 * direction_vector.x), grid_position.y - (2 * direction_vector.y))
	var hit_position_3: Vector2i = Vector2i(grid_position.x + (3 * direction_vector.x), grid_position.y - (3 * direction_vector.y))
	
	if hit_position_1 == opponent.grid_position || hit_position_2 == opponent.grid_position || hit_position_3 == opponent.grid_position:
		opponent.sub_health(4)
	
	self.sub_mana(2)
	pass
	
func action_3(opponent: BaseWizard) -> void:
	if self.current_mana < 3:
		self.sub_mana(100)
		return
	self.sub_mana(3)
	self.add_move(2)
	pass

func action_4(opponent: BaseWizard) -> void:
	var hit_array = [Vector2i(-1,-1), Vector2i(0,-1), Vector2i(1,-1), Vector2i(-1,0), Vector2i(1,0), Vector2i(-1,1), Vector2i(0,1), Vector2i(1,1), ]
	if self.current_mana < 2:
		self.sub_mana(100)
		return
	self.sub_mana(2)
	for x in hit_array:
		var hit_position = Vector2i(grid_position.x + x.x, grid_position.y - x.y)
		
		if hit_position == opponent.grid_position:
			opponent.sub_health(2)
			
			break
	pass
