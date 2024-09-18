class_name Tile
extends Node

var tile_marker = preload("res://scenes/tile_marker.tscn")

var TILE_POS_OFFSET = 4 # There is a vertical offset of 4px from the tile pos and the "grid" pos

var tile_map: TileMapLayer
var map_coords: Vector2i
var game_coords: Vector2i
var marker: TileMarker

## Neighbors maps a direction to one the Tile's adjacent neighbor Tiles.
## If a neighbor is null, it can be assumed it is an edge Tile in that direction (no neighbor).
var neighbors: Dictionary = {
	"left": null,
	"right": null,
	"up": null,
	"down": null,
	"up_left": null,
	"up_right": null,
	"down_left": null,
	"down_right": null
}

var occupant: Unit:
	# TODO: In future reevalute if this setter is needed. Custom logic is for testing as of now.
	set(new_occupant):
		occupant = new_occupant
		
		# Temp code for showing the marker
		#if occupant != null:
			#set_marker(TileMarker.Variant.SELECTED)
		#else:
			#remove_marker()
			
		# May need to add this back if we ever actually want to modulate tiles...
		#tile_map.notify_runtime_tile_data_update()

func _init(p_tile_map: TileMapLayer, p_map_coords: Vector2i, p_game_coords: Vector2i, p_occupant: Unit = null):
	tile_map = p_tile_map
	map_coords = p_map_coords 
	game_coords = p_game_coords
	occupant = p_occupant

func _to_string():
	return "Map Coords: " + str(map_coords) + ", Game Coords: " + str(game_coords) + "\n"
	
func marked():
	return marker != null
	
func occupied():
	return occupant != null

func set_neighbors():
	for direction in neighbors:
		neighbors[direction] = find_neighbor(direction)
		
func find_neighbor(direction: String) -> Tile:
	var tile_direction: TileSet.CellNeighbor
	match direction:
		"left":
			tile_direction = TileSet.CellNeighbor.CELL_NEIGHBOR_LEFT_CORNER
		"right":
			tile_direction = TileSet.CellNeighbor.CELL_NEIGHBOR_RIGHT_CORNER
		"up":
			tile_direction = TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_CORNER
		"down":
			tile_direction = TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_CORNER
		"up_left":
			tile_direction = TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_LEFT_SIDE
		"up_right":
			tile_direction = TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_RIGHT_SIDE
		"down_left":
			tile_direction = TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_LEFT_SIDE
		"down_right":
			tile_direction = TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_RIGHT_SIDE
		_:
			# Should return the current tile, since there is no true "left-side" in isometric.
			tile_direction = TileSet.CellNeighbor.CELL_NEIGHBOR_LEFT_SIDE

	var neighbor_coords: Vector2i = tile_map.get_neighbor_cell(map_coords, tile_direction)
	
	# Set the neighbor if it isn't self, and the coords map to a used cell.
	if (neighbor_coords != map_coords and tile_map.tile_coords.has(neighbor_coords)):
		return tile_map.tile_coords[neighbor_coords]
	else: 
		return null
		
func set_marker(variant: TileMarker.Variant):
	# If there is already a marker on this tile, remove it
	remove_marker()
		
	# Set the new marker.
	marker = tile_marker.instantiate()
	marker.variant = variant
	
	# Aligns the marker with the top of the tile. 
	marker.position = Vector2(self.game_coords.x, self.game_coords.y + TILE_POS_OFFSET)
	
	add_child(marker)

func remove_marker():
	if marked():
		marker.queue_free()
		marker = null
