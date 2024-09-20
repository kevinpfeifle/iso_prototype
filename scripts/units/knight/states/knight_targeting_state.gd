class_name KnightTargetingState
extends UnitSelectedState

## The Targeting State is very similar to the Selected State. Perhaps these can be combined into 
## one in the future for simplicity with a flag denoting which type of selecting is being done.
func enter(args):
	super(args)
	set_neighbor_tiles_targetable()

func exit():
	super()
	remove_neighbor_tiles_targetable()

func set_neighbor_tiles_targetable():
	for direction in unit.cur_tile.neighbors.keys():
		if unit.cur_tile.neighbors[direction] != null:
			var tile = unit.cur_tile.neighbors[direction]
			if tile.occupied():
				tile.set_marker(TileMarker.Variant.TARGETED)
				tile.marker.clicked.connect(_on_selected_tile_clicked)
				marked_tiles.append(tile)
	
	if marked_tiles.size() == 0:
		transition.emit("idle", [])

func remove_neighbor_tiles_targetable():
	for tile in marked_tiles:
		tile.remove_marker()
	marked_tiles = []
	get_tree()
# This has an issue where clicking on a Unit in the region where it overlaps a tile results in
# the unit getting selected for targeting, and then immediately the click registers on the tile,
# firing this function.
# TODO: Find a better way to handle the clicking so the event gets consumed after its handled once.
# get_viewport().set_input_as_handled() might accomplish this? This might fix a lot of the weirdness!
func _on_selected_tile_clicked(tile: Tile, variant: Variant):
	if variant == TileMarker.Variant.TARGETED:
		transition.emit("attack", [tile])
