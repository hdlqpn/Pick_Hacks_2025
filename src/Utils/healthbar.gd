class_name HealthBar
extends Node2D

@export var health_stages: Array[Texture2D]
@onready var sprite: Sprite2D = $Sprite2D

func set_health(current: int, max: int) -> void:
	var health_percentage: float = float(current) / float(max)
	var index: int = round(health_percentage * (health_stages.size() - 1))
	index = clamp(index, 0, health_stages.size() - 1)
	sprite.texture = health_stages[index]
	
func _ready() -> void:
	z_index = 1
	visible = true

func _process(delta: float) -> void:
	if get_parent():
		var wizard_position = get_parent().global_position
		var health_bar_width = sprite.texture.get_width()
		global_position = wizard_position + Vector2(+health_bar_width / 2, +30)
