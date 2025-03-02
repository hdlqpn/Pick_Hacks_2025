class_name ManaBar
extends Node2D

@export var mana_stages: Array[Texture2D]
@onready var sprite: Sprite2D = $Sprite2D

func set_mana(current: int, max: int) -> void:
	var mana_percentage: float = float(current) / float(max)
	var index: int = round(mana_percentage * (mana_stages.size() - 1))
	index = clamp(index, 0, mana_stages.size() - 1)
	sprite.texture = mana_stages[index]
	
func _ready() -> void:
	z_index = 2
	visible = true

func _process(delta: float) -> void:
	if get_parent():
		var wizard_position = get_parent().global_position
		var mana_bar_width = sprite.texture.get_width()
		global_position = wizard_position + Vector2(+mana_bar_width / 2, +50)
