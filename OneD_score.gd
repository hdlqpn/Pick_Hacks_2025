extends Node

@onready var animation_player = $AnimationPlayer
@onready var score_label = $Label
@onready var tetris_blocks = $Tetris_blocks
@onready var up_next = $up_next
var next_scene:PackedScene = preload("res://title_screen.tscn")

var score_count: int = 0

var hex_color_codes = [0xFFFFFFFF, 0x0341AEFF,0x72CB3BFF, 0xFFD500FF, 0xFF971CFF, 0xFF3213FF]

var new_color: Color

func _ready():
	animation_player.animation_finished.connect(_on_animation_finished)
	
	new_color = Color.hex(hex_color_codes[randi() % 6])
	up_next.modulate = new_color
	
func _on_animation_finished(anim_name):
	score_count += 1200
	score_label.text = "Score: " + str(score_count)
	
	animation_player.play("tetris_animation")
	
	tetris_blocks.modulate = new_color
	new_color = Color.hex(hex_color_codes[randi() % 6])
	up_next.modulate = new_color
	
	#tetris_blocks.modulate = new_color

func _input(event):
	if event.is_pressed():
		get_tree().change_scene_to_packed(next_scene)
	
