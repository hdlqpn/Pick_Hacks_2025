class_name EventHandler
extends Node

func get_action(turn: int) -> MovementAction:
	var action: MovementAction = MovementAction.new(0, 0)
	if turn == 1:
		#if Input.is_action_just_pressed("ui_up"):
		#	action = MovementAction.new(0, -1)
		#elif Input.is_action_just_pressed("ui_down"):
		#	action = MovementAction.new(0, 1)
		#elif Input.is_action_just_pressed("ui_left"):
		#	action = MovementAction.new(-1, 0)
		#elif Input.is_action_just_pressed("ui_right"):
		#	action = MovementAction.new(1, 0)
		# Player 1 (Keyboard)
		var kb_hor = int(Input.is_action_just_pressed("kb_move_right")) - int(Input.is_action_just_pressed("kb_move_left"))
		var kb_ver = int(Input.is_action_just_pressed("kb_move_down")) - int(Input.is_action_just_pressed("kb_move_up"))
		#var kb_action = 0
		
		if kb_hor != 0:
			action = MovementAction.new(kb_hor, 0)
		elif kb_ver != 0:
			action = MovementAction.new(0, kb_ver)
		else:
			action = MovementAction.new(0, 0)
		
		for i in range(1, 5):
			if Input.is_action_just_pressed("kb_action_%d" % i):
			#	kb_action = i
				break  # Stops checking once an action is detected
		
	elif turn == 2:
		# Player 2 (Joystick)
		var jp_hor = int(Input.is_action_just_pressed("jp_move_right")) - int(Input.is_action_just_pressed("jp_move_left"))
		var jp_ver = int(Input.is_action_just_pressed("jp_move_down")) - int(Input.is_action_just_pressed("jp_move_up"))
		#var jp_action = 0
		if jp_hor != 0:
			action = MovementAction.new(jp_hor, 0)
		elif jp_ver != 0:
			action = MovementAction.new(0, jp_ver)
		else:
			action = MovementAction.new(0, 0)

		for i in range(1, 5):
			if Input.is_action_just_pressed("jp_action_%d" % i):
			#	jp_action = i
				break  # Stops checking once an action is detected
		# HEY LOOK AT ME I GOT RID OF THIS WHILE TRYING TO FIX THE MOVEMENT
		#if Input.is_action_just_pressed("ui_cancel"):
			#action = EscapeAction.new()
		
	# Player 1 (Keyboard)
	#var kb_hor = int(Input.is_action_pressed("kb_move_right")) - int(Input.is_action_pressed("kb_move_left"))
	#var kb_ver = int(Input.is_action_pressed("kb_move_down")) - int(Input.is_action_pressed("kb_move_up"))
	#var kb_action = 0
	
	#for i in range(1, 5):
	#	if Input.is_action_just_pressed("kb_action_%d" % i):
	#		kb_action = i
	#		break  # Stops checking once an action is detected
	
	return action
