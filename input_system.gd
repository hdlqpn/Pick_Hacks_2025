extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Player 1 (Keyboard)
	var kb_hor = int(Input.is_action_pressed("kb_move_right")) - int(Input.is_action_pressed("kb_move_left"))
	var kb_ver = int(Input.is_action_pressed("kb_move_down")) - int(Input.is_action_pressed("kb_move_up"))
	var kb_action = 0
	
	for i in range(1, 5):
		if Input.is_action_just_pressed("kb_action_%d" % i):
			kb_action = i
			break  # Stops checking once an action is detected

	# Debug Keyboard Input
	if kb_hor != 0: print("Player 1 Moving Horizontally:", kb_hor)
	if kb_ver != 0: print("Player 1 Moving Vertically:", kb_ver)
	if kb_action != 0: print("Player 1 Action:", kb_action)

	# Player 2 (Joystick)
	var jp_hor = int(Input.is_action_pressed("jp_move_right")) - int(Input.is_action_pressed("jp_move_left"))
	var jp_ver = int(Input.is_action_pressed("jp_move_down")) - int(Input.is_action_pressed("jp_move_up"))
	var jp_action = 0

	for i in range(1, 5):
		if Input.is_action_just_pressed("jp_action_%d" % i):
			jp_action = i
			break  # Stops checking once an action is detected

	# Debug Joystick Input
	if jp_hor != 0: print("Player 2 Moving Horizontally:", jp_hor)
	if jp_ver != 0: print("Player 2 Moving Vertically:", jp_ver)
	if jp_action != 0: print("Player 2 Action:", jp_action)

	# Now you can use kb_hor, kb_ver, kb_action for Player 1
	# And jp_hor, jp_ver, jp_action for Player 2
