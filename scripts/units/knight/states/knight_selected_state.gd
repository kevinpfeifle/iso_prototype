class_name KnightSelectedState
extends UnitSelectedState

func enter(args: Array):
	super(args)
	set_neighbor_tiles_interactable()

func exit():
	super()
	remove_neighbor_tiles_interactable()

func set_neighbor_tiles_interactable():
	for direction in unit.cur_tile.neighbors.keys():
		if unit.cur_tile.neighbors[direction] != null:
			var tile = unit.cur_tile.neighbors[direction]
			if not tile.occupied():
				tile.set_marker(TileMarker.Variant.SELECTED)
				tile.marker.clicked.connect(_on_selected_tile_clicked)
				marked_tiles.append(tile)
			else:
				tile.set_marker(TileMarker.Variant.BLOCKED)
				marked_tiles.append(tile)

func remove_neighbor_tiles_interactable():
	for tile in marked_tiles:
		tile.remove_marker()
	marked_tiles = []

func _on_selected_tile_clicked(tile: Tile, variant: Variant):
	if variant == TileMarker.Variant.SELECTED:
		transition.emit("move", [tile])
