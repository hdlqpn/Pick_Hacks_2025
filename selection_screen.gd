extends Control

# Export the Color variables correctly
@export var highlight_color : Color = Color(1, 1, 0) # Yellow color for highlighting
@export var unhighlight_color : Color = Color(1, 1, 1) # White color for non-highlighted panels
@export var border_color : Color = Color(0, 1, 0) # Green color for the border when highlighted

# Declare an array to hold the panel nodes and an integer to track the selected index
var panels : Array = []
var selected_index : int = 0

# Declare an array to hold references to the text box nodes
var text_boxes : Array = []

# Textures for each panel (not directly used now, as we are changing based on TextureRects)
@export var panel_1_texture : Texture
@export var panel_2_texture : Texture
@export var panel_3_texture : Texture
@export var panel_4_texture : Texture

# To disable input after Enter is pressed
var input_disabled : bool = false

# Called when the node enters the scene tree for the first time
func _ready():
	# Gather all Panel nodes into an array
	panels = $VBoxContainer2.get_children()
	
	# Gather all TextBoxes corresponding to the panels (assuming the text boxes are named "TextBox1", "TextBox2", etc.)
	for i in range(panels.size()):
		var text_box = panels[i].get_node("TextBox" + str(i + 1))  # Example naming: "TextBox1", "TextBox2", etc.
		if text_box:
			text_boxes.append(text_box)
			text_box.visible = false  # Initially hide all text boxes

	# Debugging to check if text_boxes are being populated correctly
	print("Text Boxes: ", text_boxes)
	print("Selected Index initially: ", selected_index)

	# Initialize the highlight on the first panel
	highlight_panel(selected_index)
	# Show the text box for the first selected panel
	show_text_for_selected_panel()

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta):
	# Handle player input for navigation
	if Input.is_action_just_pressed("ui_up") and not input_disabled:  # 'W' key
		move_up()
	elif Input.is_action_just_pressed("ui_down") and not input_disabled:  # 'S' key
		move_down()

	# Check for the 'Enter' key press to select the panel
	if Input.is_action_just_pressed("ui_accept"):  # Enter key
		change_panel_texture(selected_index)
		# Disable further movement input
		input_disabled = true

# Function to handle moving the selection up
func move_up():
	selected_index -= 1
	if selected_index < 0:
		selected_index = panels.size() - 1  # Loop back to the last panel
	update_selection()

# Function to handle moving the selection down
func move_down():
	selected_index += 1
	if selected_index >= panels.size():
		selected_index = 0  # Loop back to the first panel
	update_selection()

# Function to update the selected panel's highlight and manage text boxes
func update_selection():
	# Reset the previous selected panel's highlight
	for i in range(panels.size()):
		if i == selected_index:
			highlight_panel(i)
			show_text_for_selected_panel()  # Show text box for the selected panel
		else:
			unhighlight_panel(i)
			hide_text_for_unselected_panel(i)  # Hide text box for unselected panel

# Function to highlight the currently selected panel
func highlight_panel(index):
	var panel = panels[index]
	# Change the modulate color for the panel
	panel.modulate = highlight_color
	
	# Find the border ColorRect and change its color
	var border = panel.get_node("ColorRect")  # Assuming the ColorRect is named "ColorRect"
	if border:
		border.color = border_color

# Function to remove the highlight from a panel
func unhighlight_panel(index):
	var panel = panels[index]
	# Reset the modulate color for the panel
	panel.modulate = unhighlight_color
	
	# Find the border ColorRect and reset its color
	var border = panel.get_node("ColorRect")  # Assuming the ColorRect is named "ColorRect"
	if border:
		border.color = unhighlight_color

# Function to change the texture of the currently selected panel
func change_panel_texture(index):
	var panel = panels[index]
	
	# Dynamically generate the name of the corresponding TextureRect (Chosen_Image, Chosen_Image2, Chosen_Image3...)
	var texture_node_name = "Chosen_Image" + str(index + 1)  # Generate names like "Chosen_Image1", "Chosen_Image2", etc.
	var texture_node = panel.get_node(texture_node_name)  # Get the node dynamically based on index

	if texture_node:
		print("Found texture node: ", texture_node_name)
		# Get the current texture from the TextureRect (this is the texture we want the panel to change to)
		var current_texture = texture_node.texture
		# Apply the texture to the panel itself (changing the panel's texture to the TextureRect's current texture)
		panel.get_node("TextureRect").texture = current_texture  # Assuming the panel has a TextureRect to apply the texture to
	else:
		print("Texture node not found for panel at index: ", index)

# Function to show the text box for the selected panel
func show_text_for_selected_panel():
	# Ensure that selected_index is within valid bounds for text_boxes
	if selected_index >= 0 and selected_index < text_boxes.size():
		var text_box = text_boxes[selected_index]
		if text_box:
			text_box.visible = true
		else:
			print("Text box not found at index: ", selected_index)  # Debugging line
	else:
		print("Invalid index for text box: ", selected_index)  # Debugging line

# Function to hide the text box for an unselected panel
func hide_text_for_unselected_panel(index):
	# Ensure that index is within valid bounds for text_boxes
	if index >= 0 and index < text_boxes.size():
		var text_box = text_boxes[index]
		if text_box:
			text_box.visible = false
		else:
			print("Text box not found at index: ", index)  # Debugging line
	else:
		print("Invalid index for text box: ", index)  # Debugging line
