extends TileMapLayer

var tile_coords = {}
var units = []

func _ready():
	var local_map = get_used_cells()
	var game_coords = local_map.map(func(coords): 
		return map_to_local(coords)
	)

	# Create and set each Tile instance.
	for i in local_map.size():
		var map_coords = local_map[i]
		var tile_game_coords = game_coords[i]
		var tile = Tile.new(self, map_coords, tile_game_coords)
		tile_coords[map_coords] = tile
		add_child(tile) # Tile must be added as a child of the map, so that we can add marker sprites later.
		
	# Map each tile to its eight neighbors for later movement calculations.
	for tile in tile_coords.keys():
		tile_coords[tile].set_neighbors()
	
	# Get the list of units present on this level.
	for unit in %PlayerUnits.get_children():
		units.append(unit)
		
	for unit in %CompUnits.get_children():
		units.append(unit)

# TODO: Add this back if you ever need to actually modulate the color of tiles.	
#func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	#for unit in units:
		#if unit.cur_tile != null and coords == unit.cur_tile.map_coords:
			#return true
		#elif unit.prev_tile != null and coords == unit.prev_tile.map_coords:
			#return true
	#return false
#
#func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	#var modulated = false
	#for unit in units:
		#if unit.cur_tile != null and coords == unit.cur_tile.map_coords:
			#tile_data.set_modulate(Color(1.5, 1.5, 1.5, 1))
			#modulated = true
	#if not modulated:
		#tile_data.set_modulate(Color(1, 1, 1, 1)) # default tile color
