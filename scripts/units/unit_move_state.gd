class_name UnitMoveState
extends UnitState

## Args[0] should be the Tile the Unit is supposed to move to.
func enter(args: Array):
	super(args)
	unit.animation_player.play("move")
	move_tiles(args[0])

func exit():
	super()
	
func physics_update(_delta):
	if unit.velocity == Vector2(0,0):
		transition.emit("idle", [])

func move_tiles(new_tile: Tile):
	if new_tile != null and not new_tile.occupied():
		unit.prev_tile = unit.cur_tile
		unit.prev_tile.occupant = null
		unit.cur_tile = new_tile
		unit.cur_tile.occupant = unit
