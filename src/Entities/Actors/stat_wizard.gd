class_name StatWizard
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
	texture_down = preload("res://144_size_character_sprites/Statistician_Wizard_Front_View.png")
	texture_up = preload("res://144_size_character_sprites/Statistician_Wizard_Back_View.png")
	texture_left = preload("res://144_size_character_sprites/Statistician_Wizard_Left_View.png")
	texture_right = preload("res://144_size_character_sprites/Statistician_Wizard_Right_View.png")
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
