class_name Camera
extends Camera2D



func setup_camera(map_width: int, map_height: int, tile_size: int):
	var map_pixel_width = map_width * tile_size
	var map_pixel_height = map_height * tile_size
	
	# Center the camera at middle of the map
	position = Vector2(map_pixel_width / 2, map_pixel_height / 2)
	
	# Calculate zoom to fit the whole map in view
	var viewport_size = get_viewport_rect().size
	var zoom_x = viewport_size.x / map_pixel_width
	var zoom_y = viewport_size.y / map_pixel_height
	
	# Use the smaller zoom value to make sure the map fits
	zoom = Vector2(min(zoom_x, zoom_y), min(zoom_x, zoom_y))
