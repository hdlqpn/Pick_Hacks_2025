extends Control

var player1_Select = 0
var player2_Select = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	print(player1_Select, player2_Select)
	
	if player1_Select != 0 && player2_Select != 0:
		var next_scene = preload("res://src/Game/game.tscn")  # Load PackedScene
		var new_scene = next_scene.instantiate()  # Instantiate scene

		# Pass custom variables before switching scenes
		new_scene.player1_wizard = player1_Select
		new_scene.player2_wizard = player2_Select

		# Remove the current scene safely
		if get_tree().current_scene:
			get_tree().current_scene.queue_free()  # Free the old scene first

		# Set the new scene properly
		get_tree().root.add_child(new_scene)  # Add to the scene tree
		get_tree().current_scene = new_scene  # Now set it as the active scene

		
